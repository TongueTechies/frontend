import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tongue_techies_frontend/models/error.models.dart';
import 'package:tongue_techies_frontend/models/savedTranslation.models.dart';
import 'package:tongue_techies_frontend/models/success.models.dart';
import 'package:tongue_techies_frontend/models/translation.models.dart';
import 'package:tongue_techies_frontend/screens/home/home_screen_english.dart';

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

  Future<dynamic> saveTranslation(
      String english_text, String newari_text) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.savedTranslationUrl);
      Object? accessToken = prefs.get("accessToken");
      if (accessToken == null) {
        Get.offAll(() => HomeScreenEn());
        print("You need to login first!");
        return;
      }
      var body = {"english_text": english_text, "newari_text": newari_text};

      var response = await http.post(url, body: json.encode(body), headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken"
      });
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

  Future<dynamic> getAllSavedTranslations() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.savedTranslationUrl);
      Object? accessToken = prefs.get("accessToken");
      if (accessToken == null) {
        Get.offAll(() => HomeScreenEn());
        print("You need to login first!");
        return;
      }

      var response = await http.get(url, headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json"
      });
      var responseJson = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        SavedTranslation model = savedTranslationFromJson(responseJson);
        return model;
      } else {
        Errors errors = errorsFromJson(responseJson);
        return errors;
      }
    } catch (error) {
      rethrow;
    }
  }
}
