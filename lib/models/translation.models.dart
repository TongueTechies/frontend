// To parse this JSON data, do
//
//     final translationModel = translationModelFromJson(jsonString);

import 'dart:convert';

TranslationModel translationModelFromJson(String str) =>
    TranslationModel.fromJson(json.decode(str));

String translationModelToJson(TranslationModel data) =>
    json.encode(data.toJson());

class TranslationModel {
  bool success;
  TranslationData data;
  String message;

  TranslationModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) =>
      TranslationModel(
        success: json["success"],
        data: TranslationData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class TranslationData {
  String translatedText;

  TranslationData({
    required this.translatedText,
  });

  factory TranslationData.fromJson(Map<String, dynamic> json) =>
      TranslationData(
        translatedText: json["translated_text"],
      );

  Map<String, dynamic> toJson() => {
        "translated_text": translatedText,
      };
}
