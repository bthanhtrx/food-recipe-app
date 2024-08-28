import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {

  final TextEditingController textEditingController;
  final bool isObscure;
  final String hintText;
  final String? Function(String?) validate;

  const AuthFormField(
      {super.key, required this.textEditingController, this.isObscure = false, required this.hintText, required this.validate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        validator: validate,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 2),
            ),
            hintText: hintText),
        controller: textEditingController,
        obscureText: isObscure,
      ),
    );
  }
}