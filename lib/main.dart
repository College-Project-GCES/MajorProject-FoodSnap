import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodsnap/pages/home_page.dart';
import 'package:foodsnap/pages/welcome.dart';
import 'dart:io';
import 'package:foodsnap/models/note.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:foodsnap/controller/provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(DetailsAdapter());
  var dbox = await Hive.openBox<Details>('details');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderApp()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: "assets/images/foodsnaplogo1.png",
          duration: 2000,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          nextScreen: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator if the authentication state is still being checked
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                User? user = snapshot.data;
                if (user != null && user.emailVerified) {
                  // User is logged in and email is verified, redirect to HomePage
                  return const HomePage();
                } else {
                  // User is logged in but email is not verified, show WelcomePage
                  return const WelcomePage();
                }
              } else {
                // User is not logged in, show WelcomePage
                return const WelcomePage();
              }
            },
          ),
        ),
      ),
    );
  }
}
