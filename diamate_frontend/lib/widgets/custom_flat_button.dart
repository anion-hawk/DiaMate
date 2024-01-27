import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final String text;
  final TextStyle buttonTextStyle;
  final VoidCallback onPressed;

  CustomFlatButton({
    required this.text,
    required this.buttonTextStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}