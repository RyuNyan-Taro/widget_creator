import 'dart:math';

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

  factory BlogPost.fromPost(dynamic post) {
    final content = post['content'] as String?;
    if (content == null || content.isEmpty) {
      throw Exception(
          'Failed to find content in the post, because of the post has null content.');
    }

    // HTML タグを削除して160文字に制限する正規表現
    final description = post['content']
            .replaceAll(RegExp(r'<[^>]*>'), '')
            .substring(0, min(40, content.length)) +
        '...';

    return BlogPost(
      id: post['id'],
      title: post['title'],
      description: description,
      content: post['content'],
      date: DateTime.parse(post['publishedAt'])
          .toString()
          .split(' ')[0], // YYYY-MM-DD形式
      readTime: '${(post['content'].length / 500).ceil()} min read',
      slug: post['id'],
    );
  }
}
