// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  bool success;
  ProfileData data;
  String message;

  Profile({
    required this.success,
    required this.data,
    required this.message,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        success: json["success"],
        data: ProfileData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class ProfileData {
  int id;
  String firstName;
  String lastName;
  String email;

  ProfileData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
      };
}
