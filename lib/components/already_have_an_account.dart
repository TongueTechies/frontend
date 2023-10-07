import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';

class AlreadyHaveAnAccountCheck extends StatefulWidget {
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  final bool login;
  final GestureTapCallback press;

  @override
  State<AlreadyHaveAnAccountCheck> createState() =>
      _AlreadyHaveAnAccountCheckState();
}

class _AlreadyHaveAnAccountCheckState extends State<AlreadyHaveAnAccountCheck> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.login
              ? "Don't have an account ? "
              : "Already have an account ? ",
          style: const TextStyle(
            color: kPrimaryColor,
          ),
        ),
        GestureDetector(
          onTap: widget.press,
          child: Text(
            widget.login ? "Sign Up" : "Sign In",
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
