import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  const _ArticleMain({required this.article});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('yyyy/MM/dd').format(article.createdAt),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '#${article.tags.join(' #')}', // ←文字列の配列をjoinで結合
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontStyle: FontStyle.italic, // ←フォントスタイルを斜体に変更
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              Column(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  Text(
                    article.likesCount.toString(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(article.user.profileImageUrl),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.user.id,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ]
          )
        ],
      ),
    );
  }
}