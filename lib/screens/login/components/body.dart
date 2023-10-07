import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tongue_techies_frontend/components/already_have_an_account.dart';
import 'package:tongue_techies_frontend/components/rounded_button.dart';
import 'package:tongue_techies_frontend/components/rounded_input_field.dart';
import 'package:tongue_techies_frontend/components/rounded_password_field.dart';
import 'package:tongue_techies_frontend/helpers/snackbar.dart';
import 'package:tongue_techies_frontend/models/error.models.dart';
import 'package:tongue_techies_frontend/models/login.models.dart';
import 'package:tongue_techies_frontend/screens/home/home_screen_english.dart';
import 'package:tongue_techies_frontend/screens/login/components/background.dart';
import 'package:tongue_techies_frontend/screens/sign_up/sign_up_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tongue_techies_frontend/services/login.service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  LoginModel? model;
  Errors? errors;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
              controller: emailController,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
              controller: passwordController,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                try {
                  dynamic result = await LoginAPIService()
                      .login(emailController.text, passwordController.text);

                  print(result);
                  if (result is LoginModel) {
                    model = result;
                    if (model!.success) {
                      SharedPreferences pref = await prefs;
                      await pref.setString(
                          "accessToken", model!.data.accessToken);
                      await pref.setString(
                          "refreshToken", model!.data.refreshToken);
                      Get.off(() => const HomeScreenEn());
                      generateSuccessSnackbar("Success", model!.message);
                    }
                  } else if (result is Errors) {
                    errors = result;
                    generateErrorSnackbar("Error", errors!.message);
                    passwordController.text = "";
                  } else {
                    generateErrorSnackbar("Error", "Something went wrong!");
                  }
                } catch (e) {
                  generateErrorSnackbar("Error", e.toString());
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
