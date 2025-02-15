import 'package:flutter/material.dart';

class HasSubWidgetPage extends StatelessWidget {
  const HasSubWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Has Sub Widget'),
      ),
      body: _CharacterCard()
      );
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Card(
        color: Colors.red,
        child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'This is a super red Card!',
              style: TextStyle(color: Colors.white),
            )
        ),
      ),
    );
  }

}