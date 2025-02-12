import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Card Page'),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: _MyCards(),
          ),
        ));
  }
}

class _MyCards extends StatelessWidget {
  const _MyCards();

  @override
  Widget build(BuildContext context) {
    final List<String> cardTexts = [
      'Horizontal and vertical',
      'Square tiles',
      'Has sub widgets',
      'Update with state',
      'Action buttons'
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(cardTexts.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SizedBox(
            width: 300,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    SizedBox(width: 16),
                    Text(cardTexts[index]),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
