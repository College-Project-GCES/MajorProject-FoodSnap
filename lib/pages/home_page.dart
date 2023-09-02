import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/auth/main_page.dart';
import 'package:foodsnap/pages/camera.dart';
import 'package:foodsnap/widgets/bottom_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String username = '';

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final email = user.email;

        final userQuery = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (userQuery.docs.isNotEmpty) {
          final userData = userQuery.docs.first.data() as Map<String, dynamic>;
          setState(() {
            username = userData['username'] ?? '';
          });
        }
      }
    } catch (error) {
      print("Error fetching username: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: 'logo', // Unique tag for the hero animation
              child: Image.asset(
                'assets/images/FoodSnapLogo.png',
                height: 50,
                width: 50,
              ),
            ),
            Text(
              'Welcome, $username',
              style: TextStyle(
                color: Color.fromARGB(255, 13, 46, 31),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Hero(
              tag: 'title', // Unique tag for the hero animation
              child: Material(
                type: MaterialType.transparency, // Make it transparent for hero
                child: Text(
                  'Identify What\'s in Your Food Photos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2DB040),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Upload an image of food and let us identify it for you.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            AnimatedContainer(
              duration: Duration(seconds: 1), // Animation duration
              curve: Curves.easeInOut, // Custom animation curve
              width:
                  MediaQuery.of(context).size.width * 0.6, // Responsive width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2DB040),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Upload Image'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 0,
        onTap: (int index) async {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraPage()),
            );
          } else if (index == 1) {
            FirebaseAuth.instance.signOut();
            await _googleSignIn.disconnect();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const MainScreen(),
              ),
              ModalRoute.withName('/'),
            );
          }
        },
      ),
    );
  }
}


