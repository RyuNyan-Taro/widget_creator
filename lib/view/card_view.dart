import 'package:flutter/material.dart';
import 'package:widget_creator/view/horizontal_and_vertical_view.dart';
import 'package:widget_creator/view/square_tiles_view.dart';
import 'package:widget_creator/view/has_sub_widget_view.dart';


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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(_cardDataList.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _TextCard(
              text: _cardDataList[index].text,
              nextPage: _cardDataList[index].nextPage
          )
        );
      }),
    );
  }
}

final List<_CardData> _cardDataList = [
  _CardData(
    text: 'Horizontal and vertical',
    nextPage: () => const HorizontalAndVerticalPage(),
  ),
  _CardData(
    text: 'Square tiles',
    nextPage: () => const SquareTilesPage(),
  ),
  _CardData(
    text: 'Has sub widgets',
    nextPage: () => const HasSubWidgetPage(),
  ),
  _CardData(
    text: 'Update with state',
    nextPage: () => const _DummyPage(),
  ),
  _CardData(
    text: 'Action buttons',
    nextPage: () => const _DummyPage(),
  ),
  _CardData(
    text: 'API response to UI',
    nextPage: () => const _DummyPage(),
  )
];


class _CardData {
  final String text;
  final Widget Function() nextPage;

  _CardData({required this.text, required this.nextPage});
}

class _TextCard extends StatelessWidget {

  final String text;
  final Widget Function() nextPage;

  const _TextCard({
    required this.text,
    required this.nextPage
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
          nextPage(),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),);
      },
      leading: Icon(Icons.person_2_rounded),
      title : Text(text)
    );
  }
}

class _DummyPage extends StatelessWidget {
  const _DummyPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dummy Page'),
      ),
      body: const Center(
        child: Text('It has been creating, please wait with relax.'),
      ),
    );
  }
}
