// test/authentication_service_test.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';

void main() {
  late AuthService authClient;
  SharedPreferences.setMockInitialValues({});
  setUpAll(() async {
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
        url: dotenv.env['SUPABASE_PROJECT_URL'] ?? '',
        anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '');
    authClient = AuthService();
  });

  test('add user without error', () async {
    final response = await authClient.signUp(
        email: 'testmail@gmail.com',
        userName: 'test_user',
        password: 'test_password^@:00¥');
  });
}
