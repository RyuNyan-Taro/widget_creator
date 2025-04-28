import 'package:flutter/material.dart';
import 'package:widget_creator/features/horizontal_and_vertical_view/horizontal_and_vertical_view.dart';
import 'package:widget_creator/features/square_tiles/square_tiles_view.dart';
import 'package:widget_creator/features/has_sub_widget/has_sub_widget_view.dart';
import 'package:widget_creator/features/api_response_to_ui/screens/api_response_to_ui_view.dart';
import 'package:widget_creator/shared/dummy_view.dart';
part '_my_cards.dart';


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
