import 'package:flutter/material.dart';

class HasSubWidgetPage extends StatelessWidget {
  const HasSubWidgetPage({super.key});

  final List<Map<String, dynamic>> characterData = _characterData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Has Sub Widget'),
      ),
      body: _CharacterCards()
    );
  }
}

class _CharacterCards extends StatelessWidget {
  const _CharacterCards();

  final List<Map<String, dynamic>> characterData = _characterData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: characterData.length,
      itemBuilder: (context, index) {
        final data = characterData[index];
        return _CharacterCard(
          cardColor: data['cardColor'],
          icon: data['icon'],
          mainIconColor: data['mainIconColor'],
          subIconColor: data['subIconColor'],
        );
      },
    );
  }
}

const _characterData = [
{
'cardColor': Colors.blue,
'icon': Icons.person,
'mainIconColor': Colors.green,
'subIconColor': Colors.orange,
},
{
'cardColor': Colors.blueGrey,
'icon': Icons.accessible_forward_outlined,
'mainIconColor': Colors.yellow,
'subIconColor': Colors.orange,
},
{
'cardColor': Colors.blueGrey,
'icon': Icons.accessible_forward_outlined,
'mainIconColor': Colors.yellow,
'subIconColor': Colors.orange,
},
{
'cardColor': Colors.blueGrey,
'icon': Icons.accessible_forward_outlined,
'mainIconColor': Colors.yellow,
'subIconColor': Colors.orange,
},
{
'cardColor': Colors.blueGrey,
'icon': Icons.accessible_forward_outlined,
'mainIconColor': Colors.yellow,
'subIconColor': Colors.orange,
},
{
'cardColor': Colors.blueGrey,
'icon': Icons.accessible_forward_outlined,
'mainIconColor': Colors.yellow,
'subIconColor': Colors.orange,
},
];

class _CharacterCard extends StatelessWidget {

  const _CharacterCard({
    required this.cardColor,
    required this.icon,
    required this.mainIconColor,
    required this.subIconColor
  });

  final Color cardColor;
  final IconData icon;
  final Color mainIconColor;
  final Color subIconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 250,
      child: Card(
        color: cardColor,
        child: Column(
          children: [
            const _NameAndType(name: 'Taro', type: 'Normal'),
            const _NameAndType(name: 'Hanako', type: 'Super'),
            Row(
              children: [
                const Spacer(flex: 1,),
                const Text('icon name'),
                const SizedBox(width: 12,),
                Icon(icon, color: mainIconColor, size: 48.0),

              ]
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: subIconColor, size: 120.0),
                Icon(icon, color: subIconColor, size: 120.0),
              ])
          ],
        )
      )
    );
  }
}

class _NameAndType extends StatelessWidget {
  const _NameAndType ({required this.name, required this.type});

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