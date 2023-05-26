import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, bool isError) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
    ),
  );
}
