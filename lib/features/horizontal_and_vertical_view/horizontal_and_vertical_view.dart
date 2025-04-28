import 'dart:math';
import 'package:flutter/material.dart';

class HorizontalAndVerticalPage extends StatelessWidget {
  const HorizontalAndVerticalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal and Vertical'),
      ),
      body: _VerticallyHorizontalCardsList(
        verticalCount: 20,
        horizontalCount: 20,
        cardHeight: 100,
        cardWidth: 100,
        iconSize: 48,
      ),
    );
  }
}

class _VerticallyHorizontalCardsList extends StatelessWidget {

  const _VerticallyHorizontalCardsList({
    this.verticalCount = 10,
    this.horizontalCount = 10,
    this.cardHeight = 100,
    this.cardWidth = 100,
    this.iconSize = 48,});

  final int verticalCount;
  final int horizontalCount;
  final double cardWidth;
  final double cardHeight;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(verticalCount, (index) {
          return _HorizontalCards(
            itemCount: horizontalCount,
            cardHeight: cardHeight,
            cardWidth: cardWidth,
            iconSize: iconSize,
          );
        }),
      ),
    );
  }
}

class _HorizontalCards extends StatelessWidget {
  const _HorizontalCards({
    this.itemCount = 10,
    this.cardHeight = 100,
    this.cardWidth = 100,
    this.iconSize = 48,
  });
  final int itemCount;
  final double cardHeight;
  final double cardWidth;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _RandomIconWidget(
              width: cardWidth,
              iconSize: iconSize,
            ),
          );
        },
      ),
    );
  }
}

class _RandomIconWidget extends StatefulWidget {
  const _RandomIconWidget({
    this.width = 100,
    this.iconSize = 48,
  });
  final double width;
  final double iconSize;

  @override
  State<_RandomIconWidget> createState() => _RandomIconWidgetState();
}

class _RandomIconWidgetState extends State<_RandomIconWidget> {
  late IconData _iconData;
  late Color _iconColor;

  @override
  void initState() {
    super.initState();
    _iconData = _getRandomIconData();
    _iconColor = _getRandomColor();
  }

  IconData _getRandomIconData() {
    final Random random = Random();
    final int minCodePoint = 0xe000;
    final int maxCodePoint = 0xf8ff;
    final int randomCodePoint =
        minCodePoint + random.nextInt(maxCodePoint - minCodePoint);
    return IconData(randomCodePoint, fontFamily: 'MaterialIcons');
  }

  Color _getRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  void _changeIcon() {
    setState(() {
      _iconData = _getRandomIconData();
      _iconColor = _getRandomColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Card(
        child: InkWell(
          onTap: _changeIcon,
          child: Icon(
            _iconData,
            size: widget.iconSize,
            color: _iconColor,
          ),
        ),
      ),
    );
  }
}