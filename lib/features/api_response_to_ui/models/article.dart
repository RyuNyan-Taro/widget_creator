import 'package:widget_creator/features/api_response_to_ui/models/user.dart';

class Article {
  Article ({
    required this.title,
    required this.user,
    this.likesCount = 0,
    this.tags = const [],
    required this.createdAt,
    required this.url,});

  final String title;
  final User user;
  final int likesCount;
  final List<String> tags;
  final DateTime createdAt;
  final String url;

  factory Article.fromJson(dynamic json) {
    return Article(
      title: json['title'] as String,
      user: User.fromJson(json['user']),
      likesCount: json['likes_count'] as int,
      tags: List<String>.from(json['tags'].map((tag) => tag['name'])),
      createdAt: DateTime.parse(json['created_at'] as String),
      url: json['url'] as String
    );

  }

}