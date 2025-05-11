// ref: https://github.com/heyhey1028/flutter_supabase_auth/blob/main/lib/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widget_creator/features/email_authentication/screens/reset_password_screen.dart';
import 'package:widget_creator/features/email_authentication/screens/signup_screen.dart';
import 'package:widget_creator/features/email_authentication/screens/success_login_screen.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';
import 'package:widget_creator/features/email_authentication/utils/auth_handler.dart';
import 'package:widget_creator/features/email_authentication/widgets/validate_form.dart';
import 'package:widget_creator/features/top/top_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authClient = AuthService();
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    final user = await _authClient.checkAuthState();
    if (user != null && mounted) {
      _navigateToSuccess();
    } else if (mounted) {
      setState(() => _isChecking = false);
    }
  }

  void _navigateToSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SuccessLoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isChecking) {
      return const Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      ));
    }

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPo, result) async {
          await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const TopPage(title: 'Top')),
            (route) => false,
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _LoginForm(
                  onLoginSuccess: (user) {
                    _navigateToSuccess();
                  },
                ),
                const SizedBox(height: 8.0),
                _LoginLinks(),
              ],
            ),
          ),
        ));
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
  final _isLoadingNotifier = ValueNotifier<bool>(false);
  final _authClient = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _isLoadingNotifier.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    await AuthHandler.handle(
      context: context,
      loadingNotifier: _isLoadingNotifier,
      authCallback: () => _authClient.loginWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ),
      onSuccess: (response) {
        if (response.user != null) {
          widget.onLoginSuccess(response.user!);
        }
      },
    );
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
          ValueListenableBuilder(
              valueListenable: _isLoadingNotifier,
              builder: (context, isLoading, child) {
                return ElevatedButton(
                  onPressed: isLoading ? null : _handleLogin,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                );
              })
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
