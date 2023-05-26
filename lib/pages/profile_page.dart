import 'package:flutter/material.dart';
import 'package:foodsnap/pages/camera_page.dart';
import 'package:foodsnap/pages/home_page.dart';
import 'package:foodsnap/widgets/bottom_navigation.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _logout() {
    // Perform logout logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: const Text('Take Photo'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text('Choose from Gallery'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'User Name',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: _logout,
            child: const Text('Logout'),
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 2,
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomePage(
                        username: '',
                      )),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraPage()),
            );
          }
        },
      ),
    );
  }
}
