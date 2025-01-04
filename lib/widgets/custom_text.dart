import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {this.hintText, required this.onchange, required this.obscureText});

  String? hintText;

  bool obscureText;
  Function(String) onchange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      style: const TextStyle(color: Colors.white),

      obscureText: obscureText,
      validator: (data) {
        if (data!.isEmpty) return 'field is required';
      },
      onChanged: onchange,
      decoration: InputDecoration(
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }
}
