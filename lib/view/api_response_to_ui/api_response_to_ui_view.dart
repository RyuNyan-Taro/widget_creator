// ref: https://zenn.dev/heyhey1028/books/flutter-basics/viewer/hands_on_intro

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:widget_creator/view/api_response_to_ui/models/article.dart';

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

  Future<List<Article>> searchQiita(String keyword) async {

    final uri = Uri.https('qiita.com', '/api/v2/items', {
      'query': 'title:$keyword',
      'per_page': '10'
    });
    final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

    final http.Response res = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode == 200) {
      final List<dynamic> body = jsonDecode(res.body);
      return body.map((dynamic json) => Article.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
