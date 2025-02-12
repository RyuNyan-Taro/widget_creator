import 'package:flutter/material.dart';

class HorizontalAndVerticalPage extends StatelessWidget {
  const HorizontalAndVerticalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal and Vertical'),
      ),
      body: const Center(
        child: Text('Horizontal and Vertical Page'),
      ),
    );
  }
}