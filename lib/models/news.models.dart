  // To parse this JSON data, do
  //
  //     final newsModel = newsModelFromJson(jsonString);

  import 'dart:convert';

  NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

  String newsModelToJson(NewsModel data) => json.encode(data.toJson());

  class NewsModel {
    bool success;
    List<Datum> data;
    String message;

    NewsModel({
      required this.success,
      required this.data,
      required this.message,
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
          success: json["success"],
          data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
          message: json["message"],
        );

    Map<String, dynamic> toJson() => {
          "success": success,
          "data": List<dynamic>.from(data.map((x) => x.toJson())),
          "message": message,
        };
  }

  class Datum {
    String title;
    String link;
    String thumbnailUrl;

    Datum({
      required this.title,
      required this.link,
      required this.thumbnailUrl,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
          title: json["title"],
          link: json["link"],
          thumbnailUrl: json["thumbnail_url"],
        );

    Map<String, dynamic> toJson() => {
          "title": title,
          "link": link,
          "thumbnail_url": thumbnailUrl,
        };
  }
