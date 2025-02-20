import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? error;
  dynamic onChange;

  AppInput(
      {required this.hintText,
      required this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.error,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: TextField(
          controller: controller,
          onChanged: onChange,
          decoration: InputDecoration(
            prefix: prefixIcon,
            hintText: hintText,
            errorText: error,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
