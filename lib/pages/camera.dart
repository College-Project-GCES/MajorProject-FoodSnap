import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:foodsnap/components/custom_icon.dart';
import 'package:foodsnap/components/my_button.dart';
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
        backgroundColor: const Color.fromARGB(255, 189, 236, 241),
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
            if (imageFile != null)
              Container(
                width: 640,
                height: 480,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: FileImage(imageFile!), fit: BoxFit.cover),
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
                  color: const Color.fromARGB(255, 155, 221, 131),
                  border: Border.all(
                      width: 8, color: const Color.fromARGB(31, 55, 104, 64)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  'select image',
                  style: TextStyle(fontSize: 26),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      onPressed: () => getImage(source: ImageSource.camera),
                      child: const MyButton(
                        text: 'Camera',
                      )),
                ),
                Expanded(
                  child: TextButton(
                      onPressed: () => getImage(source: ImageSource.gallery),
                      child: const MyButton(
                        text: 'Gallery',
                      )),
                ),
                TextButton(
                  onPressed: () {
                    if (imageFile != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NutritionPage(imageFile: imageFile!),
                        ),
                      );
                    }
                  },
                  child: const MyButton(
                    text: 'Predict',
                  ),
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

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}

