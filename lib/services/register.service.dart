import 'dart:convert';

import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tongue_techies_frontend/models/error.models.dart';
import 'package:tongue_techies_frontend/models/login.models.dart';

class RegisterAPIService {
  Future<dynamic> register(String email, String password) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.registerUrl);
      var body = {
        "email": email,
        "password": password,
        "confirm_password": password
      };

      var response = await http.post(url,
          body: json.encode(body),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 201) {
        LoginModel model = loginModelFromJson(response.body);
        return model;
      } else {
        Errors errors = errorsFromJson(response.body);
        return errors;
      }
    } catch (error) {
      rethrow;
    }
  }
}
