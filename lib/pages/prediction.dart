import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ImageDisplay extends StatefulWidget {
  const ImageDisplay({super.key});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  String name = '';
  String confidences = '';

  Future<Response> predict(File image) async {
    final url = Uri.parse('http:// 192.168.3.104:8000/predictresult');
    final request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath('file', image.path),
    );

    final response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      final result = response.body.toString();
      final decodedResult = json.decode(result);
      print("Hi:$decodedResult");
      final diseaseValue = decodedResult['class'];
      final percentageValue = decodedResult['confidence'];
      setState(() {
        name = diseaseValue != null ? diseaseValue.toString() : '';
        confidences = percentageValue != null ? percentageValue.toString() : '';
      });
      print(result);
    } else if (response.statusCode == 422) {
      final result = response.body.toString();
      print('Validation Error: $result');
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }

    return response;
  }
}