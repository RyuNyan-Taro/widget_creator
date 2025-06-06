import 'package:flutter/material.dart';
import 'package:widget_creator/features/card/card_view.dart';
import 'package:widget_creator/features/email_authentication/screens/email_authentication_screen.dart';
import 'package:widget_creator/features/nyantaro_blog/screens/blog_list_screen.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: <Widget>[
              _NavigateText(text: 'Cards', nextPage: () => const CardPage()),
              _NavigateText(
                  text: 'Blog', nextPage: () => const BlogListScreen()),
              _NavigateText(text: 'Auth', nextPage: () => LoginPage()),
            ],
          ),
        ));
  }
}

class _NavigateText extends StatelessWidget {
  final String text;
  final Widget Function() nextPage;

  const _NavigateText({
    required this.text,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => nextPage()));
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
