import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:foodsnap/components/snackbar.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 201:
      onSuccess();
      break;
    case 400:
      showSnackBar(
        context,
        jsonDecode(response.body)['message'],
      );
      break;
    case 401:
      showSnackBar(
        context,
        jsonDecode(response.body)['message'],
      );
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(
        context,
        response.body,
      );
  }
}
