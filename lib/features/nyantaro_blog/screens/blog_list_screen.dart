import 'package:flutter/material.dart';
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

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No blog posts available'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final post = snapshot.data![index];
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
                      Row(
                        children: [
                          Text(post.date),
                          const SizedBox(width: 16),
                          Text(post.readTime),
                        ],
                      ),
                    ],
                  ),
                  onTap: () {
                    // TODO: ブログ投稿の詳細画面に遷移する処理を追加
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
