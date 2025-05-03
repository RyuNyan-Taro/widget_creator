// blog_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BlogPost {
  final String id;
  final String title;
  final String description;
  final String content;
  final String date;
  final String readTime;
  final String slug;

  BlogPost({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.date,
    required this.readTime,
    required this.slug,
  });
}

class BlogService {
  static const String _baseUrl = 'https://nyantaroblog.microcms.io/api/v1/blogs';
  final String _apiKey = dotenv.env['X_MICROCMS_API_KEY'] ?? '';
  final http.Client _client;

  BlogService({http.Client? client}) : _client = client ?? http.Client();


  Future<BlogPost?> fetchBlogPost(String postId) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/$postId'),
        headers: {
          'X-MICROCMS-API-KEY': _apiKey,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch blog post: ${response.statusCode}');
      }

      final post = json.decode(response.body);

      return _convertJsonPost(post);

    } catch (error) {
      print('Error fetching blog post $postId: $error');
      return null;
    }
  }

  Future<List<BlogPost>> fetchBlogPosts() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'X-MICROCMS-API-KEY': _apiKey,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch blog posts: ${response.statusCode}');
      }

      final data = json.decode(response.body);
      final posts = data['contents'] as List;

      return posts.map((post) {
        return _convertJsonPost(post);
      }).toList();
    } catch (error) {
      print('Error fetching blog posts: $error');
      return [];
    }
  }

  BlogPost _convertJsonPost(final post) {

    final content = post['content'] as String?;
    if (content == null || content.isEmpty) {
      throw Exception('Failed to find content in the post, because of the post has null content.');
    }

    // HTML タグを削除して160文字に制限する正規表現
    final description = post['content']
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .substring(0, min(160, content.length)) + '...';

    return BlogPost(
      id: post['id'],
      title: post['title'],
      description: description,
      content: post['content'],
      date: DateTime.parse(post['publishedAt']).toString().split(' ')[0], // YYYY-MM-DD形式
      readTime: '${(post['content'].length / 500).ceil()} min read',
      slug: post['id'],
    );
  }
}