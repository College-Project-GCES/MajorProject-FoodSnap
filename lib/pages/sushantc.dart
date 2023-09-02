// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:foodsnap/components/custom_icon.dart';
// import 'package:foodsnap/components/my_button.dart';
// import 'package:image_picker/image_picker.dart';
// import 'nutrition_page.dart';
// import 'package:http/http.dart';
// import 'package:http/http.dart' as http;

// class CameraPage extends StatefulWidget {
//   const CameraPage({Key? key}) : super(key: key);

//   @override
//   State<CameraPage> createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   late CameraController _cameraController;
//   late List<CameraDescription> _cameras;
//   File? _image;
//   late String predictedFood;

//   @override
//   void initState() {
//     super.initState();
//     initializeCamera();
//   }

//   Future<void> initializeCamera() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     _cameras = await availableCameras();
//     _cameraController = CameraController(
//       _cameras[0],
//       ResolutionPreset.medium,
//     );
//     await _cameraController.initialize();
//     setState(() {});
//   }

//   Future<void> takePicture() async {
//     if (!_cameraController.value.isTakingPicture) {
//       final XFile? imageFile = await _cameraController.takePicture();
//       if (imageFile != null) {
//         setState(() {
//           _image = File(imageFile.path);
//         });
//         // Perform image processing and prediction here
//         // Set the predictedFood variable based on the prediction result
//         predictedFood = 'Food Item'; // Replace with actual prediction
//       }
//     }
//   }

//   Future<void> pickImageFromGallery() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _image = File(pickedImage.path);
//       });
//       // Perform image processing and prediction here
//       // Set the predictedFood variable based on the prediction result
//       predictedFood = 'Food Item'; // Replace with actual prediction
//     }
//   }

//   void navigateToNutritionPage() {
    

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NutritionPage(
//           image: _image,
//           predictedFood: predictedFood,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//    if (!_cameraController.value.isInitialized) {
//     return Container(); // or a loading indicator
//   }

//     Future<Response> predict(File image) async {
//     final url = Uri.parse('http://192.168.1.85:8000/predict');
//     final request = http.MultipartRequest('POST', url);
//     request.files.add(
//       await http.MultipartFile.fromPath('file', _image!.path),
//     );

//     final response = await http.Response.fromStream(await request.send());
//     if (response.statusCode == 200) {
//       final result = response.body.toString();
//       final decodedResult = json.decode(result);
//       print("Hi:$decodedResult");
    
     
//     } 
   

//     return response;
//   }

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Camera Page',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: AspectRatio(
//               aspectRatio: _cameraController.value.aspectRatio,
//               child: CameraPreview(_cameraController),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               CustomIconButton(
//                 icon: Icons.camera,
//                 onPressed: takePicture,
//                 unselectedColor: const Color(0xff1A5C23),
//                 selectedColor: const Color(0xffD3BA66),
//               ),
//               CustomIconButton(
//                 icon: Icons.image,
//                 onPressed: pickImageFromGallery,
//                 unselectedColor: const Color(0xff1A5C23),
//                 selectedColor: const Color(0xffD3BA66),
//               ),
//             ],
//           ),
//           if (_image != null)
//             TextButton(
//               onPressed: () async{
//                 print('Image:$_image');
                           
              
//       // Call the predict function here
//       Response response = await predict(_image!);

//       if (response.statusCode == 200) {
//         final result = response.body.toString();
//         final decodedResult = json.decode(result);
//         print("Prediction Result: $decodedResult");
        
//         // Update the predictedFood variable based on the response
//         predictedFood = decodedResult['predictedFood']; // Replace with the actual key
//       } else {
//         // Handle error scenario
//         print("Prediction Error: ${response.statusCode}");
//       }

//       //navigateToNutritionPage(); // Navigate after prediction
//     },
//               child: const MyButton(
//                 text: "Predict",
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}


class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  File? _image;
  late String predictedFood;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras[0],
      ResolutionPreset.medium,
    );
    await _cameraController.initialize();
    setState(() {});
  }

  Future<void> takePicture() async {
    if (!_cameraController.value.isTakingPicture) {
      final XFile? imageFile = await _cameraController.takePicture();
      if (imageFile != null) {
        setState(() {
          _image = File(imageFile.path);
        });
      }
    }
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<Response> predict(File image) async {
    final url = Uri.parse('http://192.168.1.85:8000/predict'); // Replace with your API URL
    final request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath('file', _image!.path),
    );

    final response = await http.Response.fromStream(await request.send());
    return response;
  }

  void navigateToNutritionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NutritionPage(
          image: _image,
          predictedFood: predictedFood,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return Container(); // or a loading indicator
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Camera Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: _cameraController.value.aspectRatio,
              child: CameraPreview(_cameraController),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.camera),
                onPressed: takePicture,
              ),
              IconButton(
                icon: Icon(Icons.image),
                onPressed: pickImageFromGallery,
              ),
            ],
          ),
          if (_image != null)
            TextButton(
              onPressed: () async {
                print('Image: $_image');
                
                // Call the predict function here
                Response response = await predict(_image!);

                if (response.statusCode == 200) {
                  final result = response.body.toString();
                  final decodedResult = json.decode(result);
                  print("Prediction Result: $decodedResult");

                  // Update the predictedFood variable based on the response
                  setState(() {
                    predictedFood = decodedResult['predictedFood']; // Replace with the actual key
                  });

                  navigateToNutritionPage(); // Navigate after prediction
                } else {
                  // Handle error scenario
                  print("Prediction Error: ${response.statusCode}");
                }
              },
              child: Text(
                "Predict",
                style: TextStyle(color: Colors.blue),
              ),
            ),
        ],
      ),
    );
  }
}

class NutritionPage extends StatelessWidget {
  final File? image;
  final String predictedFood;

  const NutritionPage({Key? key, required this.image, required this.predictedFood})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nutrition Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              Image.file(
                image!,
                width: 200,
                height: 200,
              ),
            SizedBox(height: 20),
            Text(
              "Predicted Food: $predictedFood",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

