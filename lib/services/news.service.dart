import 'dart:convert';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tongue_techies_frontend/models/error.models.dart';
import 'package:tongue_techies_frontend/models/news.models.dart';

class NewsAPIService {
  Future<dynamic> getNews() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.newsUrl);

      var response = await http.get(url);
      var responseJson = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        NewsModel news = newsModelFromJson(responseJson);
        return news;
      } else {
        Errors errors = errorsFromJson(responseJson);
        return errors;
      }
    } catch (error) {
      rethrow;
    }
  }
}
