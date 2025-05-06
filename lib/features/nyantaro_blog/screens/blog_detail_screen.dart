import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:widget_creator/features/nyantaro_blog/services/blog_service.dart';

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
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                // Note: contentにはHTMLが含まれている可能性があるため、
                // 実際のアプリケーションではflutter_html等のパッケージを使用して
                // HTMLをレンダリングすることを推奨します
                Html(
                  data: post.content,
                  style: {
                    "body": Style(
                      fontSize: FontSize(16),
                      lineHeight: LineHeight(1.8),
                    ),
                    "p": Style(
                      margin: Margins(top: Margin(2)),
                    ),
                    "h1": Style(
                      fontSize: FontSize(24),
                      margin: Margins(top: Margin(16)),
                    ),
                    "h2": Style(
                      fontSize: FontSize(20),
                      margin: Margins(top: Margin(12)),
                    ),
                    "img": Style(
                      width: Width(double.infinity),
                      backgroundColor: Colors.grey[200],
                    ),
                    "pre": Style(
                      backgroundColor: Colors.grey[100],
                      padding: HtmlPaddings(top: HtmlPadding(8)),
                      margin: Margins(top: Margin(8)),
                    ),
                    "code": Style(
                      backgroundColor: Colors.grey[100],
                      fontFamily: "monospace",
                    ),
                  },
                  onLinkTap: (String? url, _, __) {
                    if (url != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LinkScreen(url: url)),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LinkScreen extends StatefulWidget {
  const LinkScreen({super.key, required this.url});

  final String url;

  @override
  State<LinkScreen> createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {
  late WebViewController controller = WebViewController()
    ..loadRequest(Uri.parse(widget.url));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Article Page'),
        ),
        body: WebViewWidget(controller: controller));
  }
}
