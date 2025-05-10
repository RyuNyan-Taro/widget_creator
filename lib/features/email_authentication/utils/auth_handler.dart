// lib/features/email_authentication/utils/auth_handler.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef AuthenticationCallback<T> = Future<T> Function();

class AuthHandler {
  static Future<T?> handle<T>({
    required BuildContext context,
    required ValueNotifier<bool> loadingNotifier,
    required AuthenticationCallback<T> authCallback,
    void Function(T result)? onSuccess,
    String? successMessage,
    String successTitle = 'Success',
  }) async {
    if (!context.mounted) return null;

    try {
      loadingNotifier.value = true;
      final result = await authCallback();

      if (!context.mounted) return null;

      if (successMessage != null && context.mounted) {
        await _showDialog(
          context,
          title: successTitle,
          message: successMessage,
        );
      }

      if (onSuccess != null) {
        onSuccess(result);
      }

      return result;
    } on AuthException catch (e) {
      if (!context.mounted) return null;
      await _showDialog(
        context,
        title: 'エラー',
        message: 'Authentication error: ${e.message}',
      );
    } on Exception catch (e) {
      if (!context.mounted) return null;
      await _showDialog(
        context,
        title: 'エラー',
        message: 'Unknown error: $e',
      );
    } finally {
      if (context.mounted) {
        loadingNotifier.value = false;
      }
    }
    return null;
  }

  static Future<void> _showDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
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
}
