// lib/features/email_authentication/utils/auth_handler.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widget_creator/features/email_authentication/utils/dialog.dart';

typedef AuthenticationCallback<T> = Future<T> Function();

class AuthHandler {
  static Future<T?> handle<T>({
    required BuildContext context,
    required ValueNotifier<bool> loadingNotifier,
    required AuthenticationCallback<T> authCallback,
    void Function(T result)? onSuccess,
  }) async {
    if (!context.mounted) return null;

    try {
      loadingNotifier.value = true;
      final result = await authCallback();

      if (!context.mounted) return null;

      if (onSuccess != null) {
        onSuccess(result);
      }

      return result;
    } on AuthException catch (e) {
      if (!context.mounted) return null;
      await showErrorDialog(context, 'Authentication error: ${e.message}');
    } on Exception catch (e) {
      if (!context.mounted) return null;
      await showErrorDialog(context, 'Unknown error: $e');
    } finally {
      if (context.mounted) {
        loadingNotifier.value = false;
      }
    }
    return null;
  }
}
