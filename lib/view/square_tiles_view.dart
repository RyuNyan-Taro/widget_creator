import 'package:flutter/material.dart';

class SquareTilesPage extends StatelessWidget {
  const SquareTilesPage ({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Square Tiles'),
        backgroundColor: Colors.blueGrey,
      ),
      body: _SquareTilesBody(
        horizontalTileCount: 10,
      )
    );
  }
}

class _SquareTilesBody extends StatelessWidget {
  const _SquareTilesBody({
    required this.horizontalTileCount
});

  final int horizontalTileCount;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // _SquareTilesBody 内部で算出
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    double squareSize = screenWidth / horizontalTileCount;
    int verticalSquareCount = (screenHeight / squareSize).toInt();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: verticalSquareCount,
      itemBuilder: (context, index) {
        return SizedBox(
          height: squareSize,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: horizontalTileCount,
            itemBuilder: (context, index) {
              return _SquareWidget(
                size: squareSize,
              );
            },
          ),
        );
      },
    );
  }
}

class _SquareWidget extends StatelessWidget {
  const _SquareWidget({
    required this.size
});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
            style: BorderStyle.solid,
          ),
      ),
    );
  }
}