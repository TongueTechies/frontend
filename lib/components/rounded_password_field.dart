import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/components/text_field_container.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isPasswordVisible = false; // Initially, password is obscure

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText:
            !isPasswordVisible, // Toggle obscureText based on visibility state
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.password,
            color: kPrimaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible; // Toggle visibility
              });
            },
            child: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
