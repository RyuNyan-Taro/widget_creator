part of 'card_view.dart';

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
    nextPage: () => const DummyPage(),
  ),
  _CardData(
    text: 'Action buttons',
    nextPage: () => const DummyPage(),
  ),
  _CardData(
    text: 'API response to UI',
    nextPage: () => ApiResponseToUiPage(),
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