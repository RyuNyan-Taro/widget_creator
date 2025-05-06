import 'package:flutter/material.dart';
import 'package:widget_creator/features/nyantaro_blog/services/blog_service.dart';
import 'package:widget_creator/features/nyantaro_blog/widgets/blog_content_html.dart';

class BlogDetailScreen extends StatefulWidget {
  final String blogId;
  final String title;

  const BlogDetailScreen({
    super.key,
    required this.blogId,
    required this.title,
  });

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  final BlogService _blogService = BlogService();
  late Future<BlogPost?> _blogPost;

  @override
  void initState() {
    super.initState();
    _blogPost = _blogService.fetchBlogPost(widget.blogId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<BlogPost?>(
        future: _blogPost,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('Blog post not found'),
            );
          }

          final post = snapshot.data!;
          return _PostView(post: post);
        },
      ),
    );
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
