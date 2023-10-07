import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tongue_techies_frontend/helpers/snackbar.dart';
import 'package:tongue_techies_frontend/models/error.models.dart';
import 'package:tongue_techies_frontend/models/profile.models.dart';
import 'package:tongue_techies_frontend/screens/home/home_screen_english.dart';

class ProfileAPIService {
  Future<dynamic> getProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.profileUrl);
      Object? accessToken = prefs.get("accessToken");
      if (accessToken == null) {
        Get.offAll(() => HomeScreenEn());
        generateErrorSnackbar("Error", "You need to login first!");
      }
      var response = await http
          .get(url, headers: {"Authorization": "Bearer $accessToken"});
      if (response.statusCode == 200) {
        Profile profile = profileFromJson(response.body);
        return profile;
      } else {
        Errors errors = errorsFromJson(response.body);
        return errors;
      }
    } catch (e) {
      rethrow;
    }
  }
}
