import 'package:flutter/material.dart';

class EmailValidateForm extends StatelessWidget {
  const EmailValidateForm({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ValidateForm(
        controller: controller,
        formLabel: 'Email',
        validateText: 'Please enter your email',
        keyboardType: TextInputType.emailAddress);
  }
}

class NameValidateForm extends StatelessWidget {
  const NameValidateForm({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ValidateForm(
        controller: controller,
        formLabel: 'User Name',
        validateText: 'Please enter your user name',
        keyboardType: TextInputType.name);
  }
}

class PasswordValidateForm extends StatelessWidget {
  const PasswordValidateForm({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ValidateForm(
        controller: controller,
        formLabel: 'Password',
        validateText: 'Please enter your password',
        obscure: true);
  }
}

class ConfirmPasswordValidateForm extends StatelessWidget {
  const ConfirmPasswordValidateForm(
      {super.key, required this.controller, required this.validateController});

  final TextEditingController controller;
  final TextEditingController validateController;

  @override
  Widget build(BuildContext context) {
    return ValidateForm(
        controller: controller,
        formLabel: 'Confirm Password',
        validateText: 'Please enter your password',
        obscure: true,
        validateController: validateController);
  }
}

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
          if (value != validateController!.text) {
            return 'value do not match';
          }
        }
        return null;
      },
    );
  }
}
