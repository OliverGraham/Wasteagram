import 'package:flutter/material.dart';
import 'package:wasteagram/components/chosen_image.dart';
import 'package:wasteagram/models/food_waste_post.dart';

import '../app.dart';

class WasteDetailScreen extends StatelessWidget {
  const WasteDetailScreen({Key? key}) : super(key: key);

  static const route = 'waste_detail_screen';

  @override
  Widget build(BuildContext context) {

    final post = ModalRoute.of(context)!.settings.arguments as FoodWastePost;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(App.title)
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _largeText(context, post.getDateForDetailScreen()),
          const SizedBox(height: 10),
          ChosenImage(imageURL: post.imageURL),
          const SizedBox(height: 50),
          _largeText(context, '${post.quantity} items'),
          _location(context, post.latitude, post.longitude),
          const SizedBox(height: 20),
        ]
      ),
    );
  }

  Widget _largeText(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.headline4);
  }

  Widget _location(BuildContext context, double? latitude, double? longitude) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
        'Location: ($latitude, $longitude)',
        style: Theme.of(context).textTheme.headline6)
      )
    );
  }


}
