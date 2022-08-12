import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/components/post_list_item.dart';
import '../models/food_waste_post.dart';

class PostList extends StatelessWidget {
  const PostList({required this.docs, Key? key}) : super(key: key);

  final List<QueryDocumentSnapshot<Object?>>? docs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: docs?.length,
      itemBuilder: (context, index) {
        return PostListItem(post: docs![index].data() as FoodWastePost);
      }
    );
  }
}
