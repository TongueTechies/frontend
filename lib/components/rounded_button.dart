import 'package:flutter/material.dart';
import 'package:tongue_techies_frontend/helpers/constants.dart';

class RoundedButton extends StatefulWidget {
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String text;
  final VoidCallback press;
  final Color color, textColor;

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 40,
            ),
            backgroundColor: widget.color,
          ),
          onPressed: widget.press,
          child: Text(
            widget.text,
            style: TextStyle(color: widget.textColor),
          ),
        ),
      ),
    );
  }
}
