import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:foodsnap/components/custom_icon.dart';
import 'package:foodsnap/components/my_button.dart';
import 'package:image_picker/image_picker.dart';
import 'nutrition_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
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
        // Perform image processing and prediction here
        // Set the predictedFood variable based on the prediction result
        predictedFood = 'Food Item'; // Replace with actual prediction
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
      // Perform image processing and prediction here
      // Set the predictedFood variable based on the prediction result
      predictedFood = 'Food Item'; // Replace with actual prediction
    }
  }

  void navigateToNutritionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NutritionPage(
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
      return Container();
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
              CustomIconButton(
                icon: Icons.camera,
                onPressed: takePicture,
                unselectedColor: const Color(0xff1A5C23),
                selectedColor: const Color(0xffD3BA66),
              ),
              CustomIconButton(
                icon: Icons.image,
                onPressed: pickImageFromGallery,
                unselectedColor: const Color(0xff1A5C23),
                selectedColor: const Color(0xffD3BA66),
              ),
            ],
          ),
          if (_image != null)
            TextButton(
              onPressed: navigateToNutritionPage,
              child: const MyButton(
                text: "Predict",
              ),
            ),
        ],
      ),
    );
  }
}
