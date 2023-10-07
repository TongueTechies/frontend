import 'package:http/http.dart' as http;
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:tongue_techies_frontend/models/error.models.dart';
import 'package:tongue_techies_frontend/models/login.models.dart';

class LoginAPIService {
  Future<dynamic> login(String email, String password) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginUrl);
      var response = await http.post(url, body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        LoginModel model = loginModelFromJson(response.body);
        return model;
      } else {
        Errors errors = errorsFromJson(response.body);
        return errors;
      }
    } catch (e) {
      rethrow;
    }
  }
}
