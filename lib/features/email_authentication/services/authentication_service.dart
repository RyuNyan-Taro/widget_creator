import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _supabase = Supabase.instance.client;

  Future<void> signUp({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      await _supabase.auth.signUp(
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

  Future<AuthResponse> loginWithPassword(
      {required String email, required String password}) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> resetPasswordWithEmail({required String email}) async {
    return await _supabase.auth.resetPasswordForEmail(email);
  }

  Future<User?> checkAuthState() async {
    final session = _supabase.auth.currentSession;
    if (session?.isExpired == false) {
      return session?.user;
    }
    return null;
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
