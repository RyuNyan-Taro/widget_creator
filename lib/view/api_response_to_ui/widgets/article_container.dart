import 'package:flutter/material.dart';
import 'package:widget_creator/view/api_response_to_ui/models/article.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _ArticlePadding.padding,
      child: _ArticleMain(article: article),
    );
  }
}

class _ArticlePadding{
  const _ArticlePadding();

  static const padding = EdgeInsets.symmetric(
    vertical: 12,
    horizontal: 16,
  );
}

class _ArticleMain extends StatelessWidget {
  const _ArticleMain({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      height: 180,
      decoration: const BoxDecoration(
        color: Color(0xFF55C500), // ← 背景色を指定
        borderRadius: BorderRadius.all(
          Radius.circular(32), // ← 角丸を設定
        ),
      ),
    );
  }
}