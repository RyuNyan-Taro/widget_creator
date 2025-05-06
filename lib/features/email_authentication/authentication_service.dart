import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<void> signUp({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'user_name': userName},
      );
    } on AuthException catch (error) {
      throw Exception('authentication error: ${error.message}');
    } on Exception catch (error) {
      throw Exception('some thing is wrong in authentication: $error');
    }
  }
}
