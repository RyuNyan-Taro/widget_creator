// blog_service.dart
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:widget_creator/features/nyantaro_blog/model/post.dart';

class BlogService {
  static const String _baseUrl =
      'https://nyantaroblog.microcms.io/api/v1/blogs';
  final String _apiKey;
  final http.Client _client;

  BlogService({String? apiKey, http.Client? client})
      : _apiKey = apiKey ?? dotenv.env['X_MICROCMS_API_KEY'] ?? '',
        _client = client ?? http.Client() {
    if (_apiKey.isEmpty) {
      throw Exception('MICROCMS_API_KEY is not set in .env file');
    }
  }

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

      return BlogPost.fromPost(post);
    } catch (error) {
      return null;
    }
  }

  Future<List<BlogPost>> fetchBlogPosts() async {
    try {
      final response = await _client.get(
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
        return BlogPost.fromPost(post);
      }).toList();
    } catch (error) {
      return [];
    }
  }
}
