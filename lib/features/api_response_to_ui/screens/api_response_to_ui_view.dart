// ref: https://zenn.dev/heyhey1028/books/flutter-basics/viewer/hands_on_intro

import 'package:flutter/material.dart';
import 'package:widget_creator/features/api_response_to_ui/models/article.dart';
import 'package:widget_creator/features/api_response_to_ui/services/qiita_service.dart';
import 'package:widget_creator/features/api_response_to_ui/widgets/article_container.dart';

class ApiResponseToUiPage extends StatefulWidget {
  const ApiResponseToUiPage({super.key});

  @override
  State<ApiResponseToUiPage> createState() => _ApiResponseToUiState();
}

class _ApiResponseToUiState extends State<ApiResponseToUiPage> {
  List<Article> articles = [];

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
          body: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 36),
              child: TextField(
                style: const TextStyle(fontSize: 18, color: Colors.black),
                decoration: const InputDecoration(
                  hintText: '検索ワードを入力してください',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                onSubmitted: (String value) async {
                  final results = await searchQiita(value);
                  setState(() => articles = results);
                },
              ),
            ),

            //todo: show message when result is zero.
            Expanded(
              child: ListView(
                children: articles
                    .map((article) => ArticleContainer(article: article))
                    .toList(),
              ),
            ),
          ])),
    );
  }
}
