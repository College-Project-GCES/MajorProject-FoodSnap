import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/pages/camera_page.dart';
import 'package:foodsnap/pages/profile_page.dart';
import 'package:foodsnap/widgets/card.dart';
import 'package:foodsnap/widgets/tile.dart';
import 'package:foodsnap/widgets/bargraph.dart';
import 'package:foodsnap/widgets/bottom_navigation.dart';

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
            const SizedBox(width: 10),
            Text(
              'Welcome, $user.username!',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: TileCard(totalCalories: 500),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomBarGraph(),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.all(0),
            child: SizedBox(
              height: 200,
              width: 60,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return const CustomCard(
                    image: 'assets/images/burger.jpg',
                    text: 'Burger',
                    totalCalorie: 200,
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


// import 'package:charts_flutter/flutter.dart' as charts;

// class HomePage extends StatelessWidget {
//   final String username = 'John Doe';

//   const HomePage({super.key}); // Replace with the actual username

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Welcome, $username!',
//               style: const TextStyle(fontSize: 24),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Bar Graph',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: BarGraph(),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.camera),
//             label: 'Camera',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BarGraph extends StatelessWidget {
//   final List<charts.Series> seriesList = [
//     charts.Series(
//       id: 'Nutrition',
//       data: [
//         NutritionData('Carbohydrate', 40),
//         NutritionData('Fat', 20),
//         NutritionData('Protein', 30),
//       ],
//       domainFn: (NutritionData nutrition, _) => nutrition.nutrient,
//       measureFn: (NutritionData nutrition, _) => nutrition.value,
//     ),
//   ];

//    BarGraph({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return charts.BarChart(
//       seriesList,
//       animate: true,
//     );
//   }
// }

// class NutritionData {
//   final String nutrient;
//   final int value;

//   NutritionData(this.nutrient, this.value);
// }
