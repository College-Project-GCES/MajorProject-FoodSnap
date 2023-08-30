import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String image;
  final String name;

  const CustomCard({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 145, 220, 196),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Image.asset(
          image,
          height: 110,
          width: 150,
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 40, top: 20),
            child: Text(name)),
      ]),
    );
  }
}
