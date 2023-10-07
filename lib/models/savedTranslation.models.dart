// To parse this JSON data, do
//
//     final savedTranslation = savedTranslationFromJson(jsonString);

import 'dart:convert';

SavedTranslation savedTranslationFromJson(String str) =>
    SavedTranslation.fromJson(json.decode(str));

String savedTranslationToJson(SavedTranslation data) =>
    json.encode(data.toJson());

class SavedTranslation {
  bool success;
  List<SavedTranslationData> data;
  String message;

  SavedTranslation({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SavedTranslation.fromJson(Map<String, dynamic> json) =>
      SavedTranslation(
        success: json["success"],
        data: List<SavedTranslationData>.from(
            json["data"].map((x) => SavedTranslationData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class SavedTranslationData {
  String englishText;
  String newariText;

  SavedTranslationData({
    required this.englishText,
    required this.newariText,
  });

  factory SavedTranslationData.fromJson(Map<String, dynamic> json) =>
      SavedTranslationData(
        englishText: json["english_text"],
        newariText: json["newari_text"],
      );

  Map<String, dynamic> toJson() => {
        "english_text": englishText,
        "newari_text": newariText,
      };
}
