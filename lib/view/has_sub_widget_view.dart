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
        child: Column(
          children: [
            const _NameAndType(name: 'Taro', type: 'Normal'),
            const _NameAndType(name: 'Hanako', type: 'Super'),
          ],
        )
      )
    );
  }

}

class _NameAndType extends StatelessWidget {
  const _NameAndType ({super.key, required this.name, required this.type});

  final String name;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(name),
          Spacer(flex: 1), // Spacerでスペースを確保
          Text(type),
          Spacer(flex: 2), // Spacerでスペースを確保
        ],
      ),
    );
  }


}