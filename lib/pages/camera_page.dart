import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodsnap/pages/foodlist_page.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final picker = ImagePicker();
  File? _image;

  Future<void> _getImageFromCamera() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodListPage(image: _image),
        ),
      );
    }
  }

  Future<void> _getImageFromGallery() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodListPage(image: _image),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: _getImageFromCamera,
            ),
            const SizedBox(height: 16),
            IconButton(
              icon: const Icon(Icons.image),
              onPressed: _getImageFromGallery,
            ),
          ],
        ),
      ),
    );
  }
}
