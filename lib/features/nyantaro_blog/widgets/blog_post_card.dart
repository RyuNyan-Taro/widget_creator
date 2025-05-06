import 'package:flutter/material.dart';
import 'package:widget_creator/features/nyantaro_blog/services/blog_service.dart';

class BlogPostCard extends StatelessWidget {
  final BlogPost post;
  final Widget Function(BuildContext, BlogPost) onTapBuilder;

  const BlogPostCard(
      {super.key, required this.post, required this.onTapBuilder});

  void _navigateToTapBuilder(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => onTapBuilder(context, post),
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
        onTap: () => _navigateToTapBuilder(context),
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
