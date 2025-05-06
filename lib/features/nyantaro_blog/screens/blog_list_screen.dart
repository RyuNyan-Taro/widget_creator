import 'package:flutter/material.dart';
import 'package:widget_creator/features/nyantaro_blog/screens/blog_detail_screen.dart';
import 'package:widget_creator/features/nyantaro_blog/services/blog_service.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  final BlogService _blogService = BlogService();
  late Future<List<BlogPost>> _blogPosts;

  @override
  void initState() {
    super.initState();
    _blogPosts = _blogService.fetchBlogPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog list'),
      ),
      body: FutureBuilder<List<BlogPost>>(
        future: _blogPosts,
        builder: _buildBlogPostList,
      ),
    );
  }
}

// internal sub widgets
Widget _buildBlogPostList(
  BuildContext context,
  AsyncSnapshot<List<BlogPost>> snapshot,
) {
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

  if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return const Center(
      child: Text('No blog posts available'),
    );
  }

  return _BlogPostListView(blogPosts: snapshot.data!);
}

class _BlogPostListView extends StatelessWidget {
  final List<BlogPost> blogPosts;

  const _BlogPostListView({
    required this.blogPosts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: blogPosts.length,
      itemBuilder: (context, index) {
        final post = blogPosts[index];
        return _BlogPostCard(post: post);
      },
    );
  }
}

class _BlogPostCard extends StatelessWidget {
  final BlogPost post;

  const _BlogPostCard({
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
