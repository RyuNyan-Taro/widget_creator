import 'package:flutter/material.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';
import 'package:widget_creator/features/email_authentication/utils/auth_handler.dart';
import 'package:widget_creator/features/email_authentication/widgets/validate_form.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final _isLoadingNotifier = ValueNotifier<bool>(false);
  final AuthService _authClient = AuthService();

  Future<void> _handleReset() async {
    if (!_formKey.currentState!.validate()) return;

    await AuthHandler.handle(
      context: context,
      loadingNotifier: _isLoadingNotifier,
      authCallback: () => _authClient.resetPasswordWithEmail(
        email: _emailController.text,
      ),
      successMessage: 'Password reset email has been sent if it is correct.',
      onSuccess: (_) {
        Navigator.of(context).pop();
      },
    );
  }

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
              EmailValidateForm(controller: _emailController),
              const SizedBox(height: 12.0),
              ValueListenableBuilder(
                  valueListenable: _isLoadingNotifier,
                  builder: (context, isLoading, child) {
                    return ElevatedButton(
                      onPressed: isLoading ? null : _handleReset,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Send email'),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
