import 'package:flutter/material.dart';
import 'package:wasteagram/models/food_waste_post.dart';

import '../screens/waste_detail_screen.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({required this.post, Key? key}) : super(key: key);

  final FoodWastePost post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _largeText(context, post.getDateForListScreen()),
      trailing: _largeText(context, post.quantity.toString()),
      onTap: () {
        Navigator.of(context).pushNamed(
            WasteDetailScreen.route,
            arguments: post
        );
      },
    );
  }

  Widget _largeText(BuildContext context, String text) {
    return Text(text, style: Theme.of(context).textTheme.headline6);
  }
}
