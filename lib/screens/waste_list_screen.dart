import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/firebase/firebase_manager.dart';
import '../components/camera_fab.dart';
import '../components/post_list.dart';

class WasteListScreen extends StatefulWidget {
  const WasteListScreen({Key? key}) : super(key: key);

  static const route = 'waste_list_screen';

  @override
  State<WasteListScreen> createState() => _WasteListScreenState();
}

class _WasteListScreenState extends State<WasteListScreen> {

  int wasteNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Wasteagram - $wasteNumber')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CameraFab(),
      body: theStreamBuilder(context)
    );
  }


  Widget theStreamBuilder(BuildContext context) {
    return StreamBuilder(

      stream: FirebaseManager.getPostsCollection().snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // initialData:  // add this somehow?

        if (snapshot.hasData) {
          // or, instead of if -> switch(snapshot.connectionState) {
          // case ConnectionState.something: do something
          //List<QueryDocumentSnapshot<Object?>>? docs = snapshot.data?.docs;

          return Column(
            children: [
              //Expanded(child: _listView(snapshot.data?.docs)),
              Expanded(child: PostList(docs: snapshot.data?.docs)),
            ]
          );
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }

  /*Widget _listView(List<QueryDocumentSnapshot<Object?>>? docs) {
    return ListView.builder(
      itemCount: docs?.length,
      itemBuilder: (context, index) {
        final post = FoodWastePost.fromJson(docs![index] as Map<String, Object?>);
        return ListTile(
          leading: Text(post.getDate()),
          title: Text(post.quantity.toString()),
          onTap: () {
            Navigator.of(context).pushNamed(
              WasteDetailScreen.route,
              arguments: post
            );
          },
        );
      },
    );
  }*/


}
