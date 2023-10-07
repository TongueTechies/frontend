import 'package:flutter/material.dart';

const Color kPrimaryColor = Color.fromARGB(255, 0, 150, 75);
const Color kPrimaryLightColor = Color.fromARGB(255, 230, 255, 240);
const Color kButtonColor = Color.fromARGB(255, 188, 122, 0);

class ApiConstants {
  static String baseUrl = "http://192.168.96.132:8000/";
  static String translateNewariUrl = "api/translation/translate/newari/";
  static String ttsNewariUrl = "api/tts/";
  static String translateEnglishUrl = "api/translation/translate/english/";
  static String newsUrl = "api/news/";
}
