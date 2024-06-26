import 'package:diamate_frontend/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon? icon;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.icon,
      this.validator,
      this.textInputType});

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
