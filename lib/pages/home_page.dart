import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/auth/main_page.dart';
import 'package:foodsnap/pages/camera_page.dart';
import 'package:foodsnap/widgets/bargraph.dart';
import 'package:foodsnap/widgets/card.dart';
import 'package:foodsnap/widgets/bottom_navigation.dart';
import 'package:foodsnap/widgets/tile.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  List<Map<String, String>> cardData = [
    {
      'image': 'assets/images/burger.jpg',
      'name': 'Burger',
    },
    {
      'image': 'assets/images/pizza.webp',
      'name': 'Pizza',
    },
    {
      'image': 'assets/images/momo.jpg',
      'name': 'MOMO',
    },
    {
      'image': 'assets/images/panipuri.jpg',
      'name': 'Panipuri',
    },
    {
      'image': 'assets/images/panner.webp',
      'name': 'Panner',
    },
    // Add more data as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/FoodSnapLogo.png',
              height: 50,
              width: 50,
            ),
            const Text(
              'Welcome, ',
              style: TextStyle(
                color: Color.fromARGB(255, 13, 46, 31),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const Center(
              child: TileCard(totalCalories: 500),
            ),
            CustomBarGraph(
              nutrients: [
                Nutrient('Carbohydrates', 30),
                Nutrient('Fat', 20),
                Nutrient('Protein', 50),
              ],
              barColors: const [
                Color.fromARGB(255, 164, 203, 236),
                Color.fromARGB(255, 247, 193, 190),
                Color.fromARGB(255, 170, 219, 171),
              ],
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Predict History',
                style: TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: SizedBox(
                height: 170,
                width: 140,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: cardData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomCard(
                      image: cardData[index]['image']!,
                      name: cardData[index]['name']!,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 0,
        onTap: (int index) async {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraPage()),
            );
          } else if (index == 2) {
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
