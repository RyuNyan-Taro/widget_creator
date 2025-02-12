import 'package:flutter/material.dart';
import 'package:widget_creator/view/card_view.dart';
import 'package:widget_creator/view/second_view.dart';

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
              _NavigateText(text: 'Text 2', nextPage: () => const SecondPage()),
              _NavigateText(text: 'Text 3', nextPage: () => const SecondPage()),
            ],
          ),
        )
    );
  }
}

class _NavigateText extends StatelessWidget {
  final String text;
  final Widget Function() nextPage;

  const _NavigateText({
    super.key,
    required this.text,
    required this.nextPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage()));
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}