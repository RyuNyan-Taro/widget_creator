import 'package:flutter/material.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';
import 'package:widget_creator/features/email_authentication/widgets/validate_form.dart';

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
              ValidateForm(
                controller: _emailController,
                formLabel: 'Email',
                validateText: 'Please enter your email',
                keyboardType: TextInputType.emailAddress,
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
                    if (!mounted) return;
                    print('fin with clear');
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Success'),
                          content: const Text(
                              'Password reset email has been sent if it is collect.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    if (!mounted) return;
                    Navigator.of(context).pop();
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
