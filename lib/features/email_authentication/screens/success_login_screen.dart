import 'package:flutter/material.dart';

class SuccessLoginPage extends StatelessWidget {
  const SuccessLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[Text('You succeeded login !')],
        ),
      ),
    );
  }
}
