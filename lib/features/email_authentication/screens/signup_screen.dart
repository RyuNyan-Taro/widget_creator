import 'package:flutter/material.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';
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
  bool isLoading = false;
  final AuthService authClient = AuthService();

  Future<void> _handleSignUp() async {
    if (isLoading) return;
    if (_formKey.currentState!.validate()) {
      await authClient.signUp(
        email: _emailController.text,
        userName: _userNameController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
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
              ValidateForm(
                controller: _emailController,
                formLabel: 'Email',
                validateText: 'Please enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              ValidateForm(
                  controller: _userNameController,
                  formLabel: 'User Name',
                  validateText: 'Please enter your user name',
                  keyboardType: TextInputType.name),
              ValidateForm(
                controller: _passwordController,
                formLabel: 'Password',
                validateText: 'Please enter your password',
                obscure: true,
              ),
              ValidateForm(
                controller: _confirmPasswordController,
                formLabel: 'Confirm Password',
                validateText: 'Please enter your password',
                obscure: true,
                validateController: _passwordController,
              ),
              const SizedBox(height: 24.0), // Spacer(

              ElevatedButton(
                onPressed: _handleSignUp,
                child: isLoading
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
