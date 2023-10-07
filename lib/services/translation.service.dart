import 'dart:convert';

import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tongue_techies_frontend/models/error.models.dart';
import 'package:tongue_techies_frontend/models/success.models.dart';
import 'package:tongue_techies_frontend/models/translation.models.dart';

class TranslationAPIService {
  Future<dynamic> translateNewari(String text) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.translateNewariUrl);
      var body = {"text": text};
      var response = await http.post(url,
          body: json.encode(body),
          headers: {"Content-Type": "application/json"});
      var responseJson = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        TranslationModel translation = translationModelFromJson(responseJson);
        return translation;
      } else {
        Errors errors = errorsFromJson(responseJson);
        return errors;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> translateEnglish(String text) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.translateEnglishUrl);
      var body = {"text": text};
      var response = await http.post(url,
          body: json.encode(body),
          headers: {"Content-Type": "application/json"});
      var responseJson = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        TranslationModel translation = translationModelFromJson(responseJson);
        return translation;
      } else {
        Errors errors = errorsFromJson(responseJson);
        return errors;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> ttsNewari(String text) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.ttsNewariUrl);
      var body = {"text": text};
      var response = await http.post(url,
          body: json.encode(body),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        Success data = successFromJson(response.body);
        return data;
      } else {
        Errors errors = errorsFromJson(response.body);
        return errors;
      }
    } catch (error) {
      rethrow;
    }
  }
}
