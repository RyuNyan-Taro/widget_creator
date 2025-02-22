// ref: https://zenn.dev/heyhey1028/books/flutter-basics/viewer/hands_on_intro

import 'package:flutter/material.dart';

class ApiResponseToUiPage extends StatelessWidget {
  const ApiResponseToUiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Hiragino Sans',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF55C500),
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Api Response To Ui'),
        ),
        body: const Center(
          child: Text('Hello, this is Api Response To Ui Page.'),
        ),
      ),
    );
  }
}