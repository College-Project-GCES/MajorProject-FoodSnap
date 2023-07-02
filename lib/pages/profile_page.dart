import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/auth/main_page.dart';
import 'package:foodsnap/components/my_button.dart';
import 'package:foodsnap/pages/camera_page.dart';
import 'package:foodsnap/pages/home_page.dart';
import 'package:foodsnap/widgets/bottom_navigation.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _image;
  // late User? _currentUser;

  @override
  void initState() {
    super.initState();
    // _currentUser = _auth.currentUser;
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: const Color.fromARGB(255, 94, 195, 133),
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 94, 195, 133),
                            size: 80,
                          ),
                        )
                      : null,
                ),
                Positioned(
                  right: -20,
                  bottom: -20,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color.fromARGB(255, 94, 195, 133),
                    child: IconButton(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Color.fromARGB(255, 12, 48, 26),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Pratigya',
              // _currentUser?.displayName ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const MainScreen(),
                  ),
                  ModalRoute.withName('/'),
                );
              },
              child: const MyButton(
                text: "LogOut",
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 2,
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
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
