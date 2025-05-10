import 'package:flutter/material.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';
import 'package:widget_creator/features/email_authentication/utils/auth_handler.dart';
import 'package:widget_creator/features/email_authentication/widgets/validate_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _isLoadingNotifier = ValueNotifier<bool>(false);
  final AuthService _authClient = AuthService();

  @override
  void dispose() {
    _isLoadingNotifier.dispose(); // ValueNotifierの解放
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    await AuthHandler.handle(
      context: context,
      loadingNotifier: _isLoadingNotifier,
      authCallback: () => _authClient.signUp(
        email: _emailController.text,
        userName: _userNameController.text,
        password: _passwordController.text,
      ),
      onSuccess: (_) {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              EmailValidateForm(controller: _emailController),
              NameValidateForm(controller: _userNameController),
              PasswordValidateForm(controller: _passwordController),
              ConfirmPasswordValidateForm(
                  controller: _confirmPasswordController,
                  validateController: _passwordController),
              const SizedBox(height: 24.0),
              ValueListenableBuilder(
                  valueListenable: _isLoadingNotifier,
                  builder: (context, isLoading, child) {
                    return ElevatedButton(
                      onPressed: isLoading ? null : _handleSignUp,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Signup'),
                    );
                  }), // Spacer(
              TextButton(
                child: const Text('Go to Login'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
