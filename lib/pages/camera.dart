import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:foodsnap/components/custom_icon.dart';
import 'package:foodsnap/components/my_button.dart';
import 'package:image_picker/image_picker.dart';
import 'NutritionPage.dart';



class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPage();
}

class _CameraPage extends State<CameraPage> {
  
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 189, 236, 241),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/FoodSnapLogo.png',
              height: 50,
              width: 50,
            ),
            const Text(
              ' select image ',
              style: TextStyle(
                color: Color.fromARGB(255, 13, 46, 31),
                fontSize: 16,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(imageFile != null)
              Container(
                width: 640,
                height: 480,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: FileImage(imageFile!),
                    fit: BoxFit.cover
                  ),
                  border: Border.all(width: 8, color: Colors.black),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              )
            else
              Container(
                width: 640,
                height: 480,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(width: 8, color: Colors.black12),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text('select image', style: TextStyle(fontSize: 26),),
              ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: ()=> getImage(source: ImageSource.camera),
                      child: const Text('Capture Image', style: TextStyle(fontSize: 18))
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: ElevatedButton(
                    
                      onPressed: ()=> getImage(source: ImageSource.gallery),
                      child: const Text('Select Image', style: TextStyle(fontSize: 18))
                  ),
                ),
                ElevatedButton(
                      onPressed: () {
                          if (imageFile != null) {
                               Navigator.push(
                              context,
                            MaterialPageRoute(
                              builder: (context) => NutritionPage(imageFile: imageFile!),
                              ),
                              );
                               }
                              },
                        child: const Text('Predict', style: TextStyle(fontSize: 18)),
                           ),

              
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void getImage({required ImageSource source}) async {
    
    final file = await ImagePicker().pickImage(
        source: source,
      maxWidth: 640,
      maxHeight: 480,
      imageQuality: 70 //0 - 100
    );
    
    if(file?.path != null){
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}
