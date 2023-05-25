import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FoodSnap',
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/foodsnaplogo1.png',
                  width: 200.0,
                  height: 200.0,
                ),
                ElevatedButton(
                  child: Text("Signup with google"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.normal),
                  ),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: Text('Signup with email'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.normal),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
