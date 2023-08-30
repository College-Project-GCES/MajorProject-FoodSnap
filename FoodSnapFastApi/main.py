from fastapi import FastAPI, UploadFile, File
from fastapi.responses import HTMLResponse
import tensorflow as tf
import altair as alt
from utils import load_and_prep, get_classes
import pandas as pd
from starlette.middleware.trustedhost import TrustedHostMiddleware
import base64
import json
import os
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# Add CORS middleware to allow requests from any origin
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Add TrustedHostMiddleware to allow requests from localhost
app.add_middleware(TrustedHostMiddleware, allowed_hosts=["*"])

# Load and prepare model
model = tf.keras.models.load_model("./models/EfficientNetB1.hdf5")
class_names = get_classes()

# Load nutrition data and diabetic recommendations
with open('diabetic.json', 'r') as file:
    diabetic_recommendations = json.load(file)

nutrition_data = pd.read_csv('nutrition.csv')

def retrieve_nutrition_values(food_category):
    # Preprocess the food_category: remove special characters, spaces, and convert to lowercase
    food_category_processed = food_category.lower().replace("-", "").replace("_", "").replace(" ", "")
    
    nutrition_values = nutrition_data[nutrition_data['product_name'].str.lower().str.replace("-", "").str.replace("_", "").str.replace(" ", "") == food_category_processed]
    if nutrition_values.empty:
        return None  # Return None if no nutrition values are available
    return nutrition_values

def get_diabetic_recommendation(food_category):
    food_category_lower = food_category.lower()
    
    for category in diabetic_recommendations:
        if category['name'].lower() == food_category_lower or food_category_lower in [name.lower() for name in category['alternateNames']]:
            return category
    return None  # Return None if no diabetic recommendation is available

def predicting(image, model):
    image = load_and_prep(image)
    image = tf.cast(tf.expand_dims(image, axis=0), tf.int16)
    preds = model.predict(image)
    pred_class = class_names[tf.argmax(preds[0])]
    pred_conf = tf.reduce_max(preds[0])
    top_5_i = sorted((preds.argsort())[0][-5:][::-1])
    values = preds[0][top_5_i] * 100
    labels = []
    for x in range(5):
        labels.append(class_names[top_5_i[x]])
    df = pd.DataFrame({
        "Top 5 Predictions": labels,
        "F1 Scores": values,
        'color': ['#EC5953', '#EC5953', '#EC5953', '#EC5953', '#EC5953']
    })
    df = df.sort_values('F1 Scores')
    return pred_class, pred_conf, df

@app.get("/", response_class=HTMLResponse)
async def home():
    return """
    <html>
    <head>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        text-align: center;
    }
    h1 {
        color: #333;
    }
    h2 {
        color: #666;
    }
    #upload-form {
        margin: 2em auto;
        padding: 2em;
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        width: 70%;
    }
    #upload-form input[type="file"] {
        display: block;
        margin: 0 auto;
        padding: 1em;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f9f9f9;
        cursor: pointer;
    }
    #upload-form input[type="submit"] {
        margin-top: 1em;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        padding: 1em 2em;
        font-size: 18px;
        cursor: pointer;
    }
    </style>
    </head>
    <body>
    <h1>Food Snap</h1>
    <h2>Identify what's in your food photos!</h2>
    <div id="upload-form">
    <form action="/predict" enctype="multipart/form-data" method="post">
        <input type="file" name="file">
        <input type="submit" value="Predict">
    </form>
    </div>
    </body>
    </html>
    """

@app.post("/predict", response_class=HTMLResponse)
async def predict(file: UploadFile = File(...)):
    image = await file.read()
    pred_class, pred_conf, df = predicting(image, model)
     
    # Convert the image data to Base64
    image_base64 = base64.b64encode(image).decode('utf-8')
    
    chart = alt.Chart(df).mark_bar().encode(
        x='F1 Scores',
        y=alt.X('Top 5 Predictions', sort=None),
        color=alt.Color("color", scale=None),
        text='F1 Scores'
    ).properties(width=600, height=400)
    chart_html = chart.to_html()
    nutrition_values = retrieve_nutrition_values(pred_class)
    nutrition_table = ""
    if nutrition_values is not None and not nutrition_values.empty:
        nutrition_table += "<h3>Nutrition Values:</h3>"
        nutrition_table += "<table>"
        nutrition_table += "<tr><th>Product Name</th><th>Energy</th><th>Carbohydrates</th><th>Sugars</th><th>Proteins</th><th>Fat</th><th>Fiber</th><th>Cholesterol</th></tr>"
        for index, row in nutrition_values.iterrows():
            nutrition_table += "<tr>"
            nutrition_table += f"<td>{row['product_name']}</td>"
            nutrition_table += f"<td>{row['energy_100g']} kJ</td>"
            nutrition_table += f"<td>{row['carbohydrates_100g']} g</td>"
            nutrition_table += f"<td>{row['sugars_100g']} g</td>"
            nutrition_table += f"<td>{row['proteins_100g']} g</td>"
            nutrition_table += f"<td>{row['fat_100g']} g</td>"
            nutrition_table += f"<td>{row['fiber_100g']} g</td>"
            nutrition_table += f"<td>{row['cholesterol_100g']} mg</td>"
            nutrition_table += "</tr>"
        nutrition_table += "</table>"
    
    diabetic_recommendations = ""
    if nutrition_values is not None:
        recommendation = get_diabetic_recommendation(pred_class)
        if recommendation is not None:
            diabetic_recommendations += "<h3>Diabetic Recommendations:</h3>"
            level_info = {
                1: ("Avoid", "Diabetic people should stay away from this food."),
                2: ("Caution", "This food can be eaten in moderation or under certain conditions."),
                3: ("Okay", "Neutral. No significant positive or negative health effects."),
                4: ("Good", "Food that is good for a diabetic person to eat."),
                5: ("Great", "Foods at this level are among the healthiest options.")
            }

            level = recommendation['level']
            level_info_tuple = level_info.get(level, ("Unknown", "No information available for this level."))
            level_name = level_info_tuple[0]
            level_reason = level_info_tuple[1]

            diabetic_recommendations += f"<p><strong>Recommendation Level:</strong> {level_name}</p>"
            diabetic_recommendations += f'<button id="more-info-button-{pred_class}" onclick="toggleInfo(\'{pred_class}\')">More Info</button>'
            diabetic_recommendations += f'<div id="info-{pred_class}" style="display: none;">'
            diabetic_recommendations += f"<p><strong>Reason:</strong><br>{level_reason}</p>"
            diabetic_recommendations += f"<p><strong>Explanation:</strong><br>{recommendation['explanation']}</p>"
            diabetic_recommendations += "<h4>Suggestions:</h4>"
            diabetic_recommendations += recommendation['suggestions'].replace("\n", "<br>")
            diabetic_recommendations += '</div>'  
            
    return HTMLResponse(content=f"""
    <html>
    <head>
    <style>
    body {{
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        text-align: center;
    }}
    h2 {{
        color: #007bff;
    }}
    img {{
        margin-top: 1em;
        border: 1px solid #ccc;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
    }}
    iframe {{
        margin-top: 1em;
        border: none;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
    }}
    </style>
    <script>
    function toggleInfo(food) {{
        var infoDiv = document.getElementById('info-' + food);
        var button = document.getElementById('more-info-button-' + food);
        if (infoDiv.style.display === 'none') {{
            infoDiv.style.display = 'block';
            button.innerText = 'Less Info';
        }} else {{
            infoDiv.style.display = 'none';
            button.innerText = 'More Info';
        }}
    }}
    </script>
    </head>
    <body>
    <h2>Prediction: {pred_class}</h2>
    <p>Confidence: {pred_conf*100:.2f}%</p>
    <img src="data:image/jpeg;base64,{image_base64}" alt="Uploaded Image" width="400">
    <div>{chart_html}</div>
    {nutrition_table}
    {diabetic_recommendations}
    </body>
    </html>
    """)
    
@app.post("/predictresult")
async def predictresult(file: UploadFile = File(...)):
    image = await file.read()
    pred_class, pred_conf, df = predicting(image, model)
    
    nutrition_values = retrieve_nutrition_values(pred_class)
    nutrition_table = ""
    if nutrition_values is not None and not nutrition_values.empty:
        nutrition_table += "Nutrition Values:\n"
    nutrition_table += f"Product Name: {nutrition_values['product_name'].iloc[0]}\n"
    nutrition_table += f"Energy: {nutrition_values['energy_100g'].iloc[0]} kJ\n"
    nutrition_table += f"Carbohydrates: {nutrition_values['carbohydrates_100g'].iloc[0]} g\n"
    nutrition_table += f"Sugars: {nutrition_values['sugars_100g'].iloc[0]} g\n"
    nutrition_table += f"Proteins: {nutrition_values['proteins_100g'].iloc[0]} g\n"
    nutrition_table += f"Fat: {nutrition_values['fat_100g'].iloc[0]} g\n"
    nutrition_table += f"Fiber: {nutrition_values['fiber_100g'].iloc[0]} g\n"
    nutrition_table += f"Cholesterol: {nutrition_values['cholesterol_100g'].iloc[0]} mg\n"

        
    recommendation = get_diabetic_recommendation(pred_class)
    diabetic_recommendations = ""
    if recommendation is not None:
        diabetic_recommendations += "Diabetic Recommendations:\n"
        diabetic_recommendations += f"Recommendation Level: {recommendation['level']}\n"
        
        if 'reason' in recommendation:
            diabetic_recommendations += f"Reason: {recommendation['reason']}\n"
        
        if 'explanation' in recommendation:
            diabetic_recommendations += f"Explanation: {recommendation['explanation']}\n"
        
        if 'suggestions' in recommendation:
            diabetic_recommendations += "Suggestions:\n" + recommendation['suggestions'].replace("\n", "\n")

    return {
        'class': pred_class,
        'confidence': float(pred_conf*100),
        'nutrition_table': nutrition_table,
        'diabetic_recommendations': diabetic_recommendations
    }


if _name_ == "_main_":
    uvicorn.run(app, host='localhost', port=8000)