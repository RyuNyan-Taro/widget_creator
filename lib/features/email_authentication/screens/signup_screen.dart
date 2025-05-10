import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';
import 'package:widget_creator/features/email_authentication/utils/dialog.dart';
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
  bool _isLoading = false;
  final AuthService _authClient = AuthService();

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() => _isLoading = true);

      await _authClient.signUp(
        email: _emailController.text,
        userName: _userNameController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      // todo: add login success page
      Navigator.of(context).pop();
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
              const SizedBox(height: 24.0), // Spacer(
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSignUp,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Signup'),
              ),
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
