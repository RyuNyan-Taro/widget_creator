import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widget_creator/features/api_response_to_ui/models/article.dart';
import 'package:widget_creator/shared/link_screen.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return _Padding(child: _ArticleCard(article));
  }
}

// Parts of ArticleContainer
class _Padding extends StatelessWidget {
  const _Padding({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: child);
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard(this.article);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LinkScreen(url: article.url)),
          );
        },
        child: _Layout(child: _Content(article: article)));
  }
}

// Parts of _ArticleCard
class _Layout extends StatelessWidget {
  const _Layout({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      height: 180,
      decoration: const BoxDecoration(
        color: Color(0xFF55C500), // ← 背景色を指定
        borderRadius: BorderRadius.all(
          Radius.circular(32), // ← 角丸を設定
        ),
        boxShadow: [
          // ← Add boxShadow here
          BoxShadow(
            color: Colors.grey, // ← Shadow color
            spreadRadius: 2, // ← How far the shadow spreads
            blurRadius: 5, // ← How blurry the shadow is
            offset: Offset(0, 3), // ← Offset of the shadow (x, y)
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Date(createdAt: article.createdAt),
        _Title(title: article.title),
        _Tags(tags: article.tags),
        const Spacer(),
        _Footer(article: article),
      ],
    );
  }
}

// Parts of _Content
class _Date extends StatelessWidget {
  const _Date({required this.createdAt});

  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('yyyy/MM/dd').format(createdAt),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class _Tags extends StatelessWidget {
  const _Tags({required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Text(
      '#${tags.join(' #')}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _Likes(likesCount: article.likesCount),
        _UserInformation(
            id: article.user.id, profileImageUrl: article.user.profileImageUrl),
      ],
    );
  }
}

class _Likes extends StatelessWidget {
  const _Likes({required this.likesCount});

  final int likesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        Text(
          likesCount.toString(),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _UserInformation extends StatelessWidget {
  const _UserInformation({required this.id, required this.profileImageUrl});

  final String id;
  final String profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(profileImageUrl),
        ),
        const SizedBox(height: 4),
        Text(
          id,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
