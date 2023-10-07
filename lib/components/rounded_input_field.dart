import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/components/text_field_container.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';

class RoundedInputField extends StatefulWidget {
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          hintText: "Your Email",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
