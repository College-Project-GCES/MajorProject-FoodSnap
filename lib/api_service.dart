import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:foodsnap/constant.dart';
import 'package:foodsnap/models/predict_model.dart';

class ApiService {
  Future<List<FoodPredictionModel>?> getFood() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<FoodPredictionModel> _model =
            FoodPredictionModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
