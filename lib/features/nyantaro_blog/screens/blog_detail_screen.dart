import 'package:flutter/material.dart';
import 'package:widget_creator/features/nyantaro_blog/services/blog_service.dart';
import 'package:widget_creator/features/nyantaro_blog/widgets/blog_content_html.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogPost post;

  const BlogDetailScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(post.title),
        ),
        body: _PostView(post: post));
  }
}

class _PostView extends StatelessWidget {
  final BlogPost post;

  const _PostView({required this.post});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          post.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        BlogContentHtml(content: post.content),
      ]),
    );
  }
}
