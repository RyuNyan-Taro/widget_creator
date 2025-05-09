// ref: https://github.com/heyhey1028/flutter_supabase_auth/blob/main/lib/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:widget_creator/features/email_authentication/screens/reset_password_screen.dart';
import 'package:widget_creator/features/email_authentication/screens/signup_screen.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final AuthService authClient = AuthService();

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      print('not varidated');
      return;
    }

    try {
      setState(() => isLoading = true);

      final response = await authClient.loginWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (response.user == null) return;

      // 成功時の処理
      Navigator.of(context).pop();
      //todo: add login error popup
      // 1. Email not confirmed
      // Error: AuthApiException(message: Email not confirmed, statusCode: 400, code: email_not_confirmed)
      // 2. Invalid login credentials
      // Error: AuthApiException(message: Invalid login credentials, statusCode: 400, code: invalid_credentials)
    } catch (e) {
      if (!mounted) return;
      await _showErrorDialog(context, e.toString());
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12.0),
              ElevatedButton(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Login'),
                onPressed: () async => await _handleLogin(),
              ),
              TextButton(
                child: const Text('Go to Signup'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
              ),
              TextButton(
                child: const Text('Do you forget password?'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('エラー'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
