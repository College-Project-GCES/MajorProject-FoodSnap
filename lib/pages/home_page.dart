import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/pages/camera_page.dart';
import 'package:foodsnap/pages/profile_page.dart';
import 'package:foodsnap/widgets/bargraph.dart';
import 'package:foodsnap/widgets/card.dart';
import 'package:foodsnap/widgets/card.dart';
import 'package:foodsnap/widgets/bottom_navigation.dart';
import 'package:foodsnap/widgets/tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

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
              'Welcome, User!',
              style: TextStyle(
                color: Color.fromARGB(255, 13, 46, 31),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: TileCard(totalCalories: 500),
          ),
          const SizedBox(height: 20),
          CustomBarGraph(),
          const SizedBox(height: 90.0),
          Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              height: 200,
              width: 150,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return const CustomCard(
                    image: 'assets/images/burger.jpg',
                    text: 'Burger',
                    totalCalorie: '200',
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 0,
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CameraPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }
}
