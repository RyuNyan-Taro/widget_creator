import 'package:flutter/material.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  final AuthService authClient = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Send email'),
                onPressed: () async {
                  //todo: add login error popup
                  // 1. Email not confirmed
                  // Error: AuthApiException(message: Email not confirmed, statusCode: 400, code: email_not_confirmed)
                  // 2. Invalid login credentials
                  // Error: AuthApiException(message: Invalid login credentials, statusCode: 400, code: invalid_credentials)
                  if (_formKey.currentState!.validate()) {
                    await authClient.resetPasswordWithEmail(
                      email: _emailController.text,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
