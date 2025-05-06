import 'package:flutter/material.dart';
import 'package:widget_creator/features/nyantaro_blog/screens/blog_detail_screen.dart';
import 'package:widget_creator/features/nyantaro_blog/services/blog_service.dart';

class BlogPostCard extends StatelessWidget {
  final BlogPost post;

  const BlogPostCard({
    super.key,
    required this.post,
  });

  void _navigateToBlogDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlogDetailScreen(
          blogId: post.id,
          title: post.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: ListTile(
        title: Text(
          post.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(post.description),
            const SizedBox(height: 8),
            _BlogPostMetadata(date: post.date, readTime: post.readTime),
          ],
        ),
        onTap: () => _navigateToBlogDetail(context),
      ),
    );
  }
}

class _BlogPostMetadata extends StatelessWidget {
  final String date;
  final String readTime;

  const _BlogPostMetadata({
    required this.date,
    required this.readTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(date),
        const SizedBox(width: 16),
        Text(readTime),
      ],
    );
  }
}
