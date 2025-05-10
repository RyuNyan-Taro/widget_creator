// ref: https://github.com/heyhey1028/flutter_supabase_auth/blob/main/lib/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widget_creator/features/email_authentication/screens/reset_password_screen.dart';
import 'package:widget_creator/features/email_authentication/screens/signup_screen.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';
import 'package:widget_creator/features/email_authentication/utils/dialog.dart';
import 'package:widget_creator/features/email_authentication/widgets/validate_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _LoginForm(
              onLoginSuccess: (user) {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 8.0),
            _LoginLinks(),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({
    required this.onLoginSuccess,
  });

  final void Function(User user) onLoginSuccess;

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _authClient = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() => _isLoading = true);

      final response = await _authClient.loginWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (response.user == null) return;

      widget.onLoginSuccess(response.user!);
    } on AuthException catch (e) {
      if (!mounted) return;
      await showErrorDialog(context, 'Authentication error: ${e.message}');
    } on Exception catch (e) {
      if (!mounted) return;
      await showErrorDialog(context, 'Unknown error: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          EmailValidateForm(controller: _emailController),
          PasswordValidateForm(controller: _passwordController),
          ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Login'),
          ),
        ],
      ),
    );
  }
}

class _LoginLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // 横幅いっぱいに広げる
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _LinkText(
          text: 'Go to Signup',
          builder: (context) => const SignUpPage(),
        ),
        _LinkText(
          text: 'Do you forget password?',
          builder: (context) => const ResetPasswordPage(),
        ),
      ],
    );
  }
}

class _LinkText extends StatelessWidget {
  const _LinkText({
    required this.text,
    required this.builder,
  });

  final String text;
  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text), // constを削除（textは変数なのでconst不可）
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: builder, // requestFocusは不要
          ),
        );
      },
    );
  }
}
