import 'package:flutter/material.dart';

class ValidateForm extends StatelessWidget {
  const ValidateForm(
      {super.key,
      required this.controller,
      required this.formLabel,
      required this.validateText,
      this.obscure = false,
      this.keyboardType,
      this.validateController});

  final TextEditingController controller;
  final String formLabel;
  final String validateText;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextEditingController? validateController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: formLabel,
      ),
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validateText;
        }
        if (validateController != null) {
          if (value != controller.text) {
            return 'value do not match';
          }
        }
        return null;
      },
    );
  }
}
