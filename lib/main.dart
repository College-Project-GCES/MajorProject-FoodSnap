import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:foodsnap/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          splash: "assets/images/foodsnaplogo1.png",
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Color.fromARGB(255, 227, 232, 236),

          // ignore: prefer_const_constructors
          nextScreen: MyHomePage(
            title: 'FOODSNAP',
          ),
        ));
  }
}
