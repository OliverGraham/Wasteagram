import 'package:flutter/material.dart';
import 'package:wasteagram/models/food_waste_post.dart';

class WasteDetailScreen extends StatelessWidget {
  const WasteDetailScreen({Key? key}) : super(key: key);

  static const route = 'waste_detail_screen';

  @override
  Widget build(BuildContext context) {

    final post = ModalRoute.of(context)!.settings.arguments as FoodWastePost;

    return Scaffold(
      body: Column(
        children: [
          _chosenImage(post.imageURL),
          // TODO: style here
          Text(post.longitude.toString()),
          Text(post.latitude.toString()),
      ]),
    );
  }

  // TODO: make into class? Needs different styling or containers here
  Widget _chosenImage(String image) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: Image.network(image, height: 375)
    );
  }

}
