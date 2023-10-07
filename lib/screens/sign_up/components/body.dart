import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/components/already_have_an_account.dart';
import 'package:tongue_techies_frontend/components/rounded_button.dart';
import 'package:tongue_techies_frontend/components/rounded_input_field.dart';
import 'package:tongue_techies_frontend/components/rounded_password_field.dart';
import 'package:tongue_techies_frontend/helpers/snackbar.dart';
import 'package:tongue_techies_frontend/models/error.models.dart';
import 'package:tongue_techies_frontend/models/login.models.dart';
import 'package:tongue_techies_frontend/screens/login/login_screen.dart';
import 'package:tongue_techies_frontend/screens/sign_up/components/background.dart';
import 'package:tongue_techies_frontend/screens/sign_up/components/or_divider.dart';
import 'package:tongue_techies_frontend/screens/sign_up/components/social_icon.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tongue_techies_frontend/services/register.service.dart';
import 'package:get/get.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginModel? registerModel;
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
              "SIGN UP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
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
              text: "SIGN UP",
              press: () async {
                try {
                  dynamic result = (await RegisterAPIService().register(
                    emailController.text,
                    passwordController.text,
                  ))!;

                  if (result is LoginModel) {
                    registerModel = result;
                    if (registerModel!.success) {
                      Get.off(() => const LoginScreen());
                      generateSuccessSnackbar(
                          "Success", registerModel!.message);
                    }
                  } else if (result is Errors) {
                    errors = result;
                    generateErrorSnackbar("Error", errors!.message);
                    passwordController.text = "";
                  } else {
                    generateErrorSnackbar(
                        "Error", "An unspecified error occurred!");
                  }
                } catch (e) {
                  generateErrorSnackbar(
                      "Error", "An unspecified error occurred!");
                  passwordController.text = "";
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
            const OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
