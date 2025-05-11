import 'package:flutter/material.dart';
import 'package:widget_creator/features/email_authentication/screens/email_authentication_screen.dart';
import 'package:widget_creator/features/email_authentication/services/authentication_service.dart';

class SuccessLoginPage extends StatefulWidget {
  const SuccessLoginPage({super.key});

  @override
  State<SuccessLoginPage> createState() => _SuccessLoginPageState();
}

class _SuccessLoginPageState extends State<SuccessLoginPage> {
  final _authClient = AuthService();
  bool _isLoading = false;

  Future<void> _handleLogout() async {
    setState(() => _isLoading = true);

    try {
      await _authClient.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ログアウトに失敗しました: ${e.toString()}')),
        );
      }
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
        title: const Text('Success'),
        actions: [
          _isLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: _handleLogout,
                  tooltip: 'ログアウト',
                ),
        ],
      ),
      body: Center(
        // Centerを追加
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 中央揃えに変更
            children: <Widget>[
              const Text(
                'You succeeded login !',
                style: TextStyle(fontSize: 20), // フォントサイズを大きくして目立たせる
              ),
              const SizedBox(height: 24), // スペースを少し広げる
              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogout,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 12.0,
                        ),
                        child: Text(
                          'ログアウト',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
