import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasteagram/firebase/firebase_manager.dart';
import '../components/camera_fab.dart';
import '../components/post_list.dart';

class WasteListScreen extends StatefulWidget {

  static const route = 'waste_list_screen';

  const WasteListScreen({Key? key}) : super(key: key);

  @override
  State<WasteListScreen> createState() => _WasteListScreenState();
}

class _WasteListScreenState extends State<WasteListScreen> {

  num wasteNumber = 0;

  @override
  Widget build(BuildContext context) {
    return _theStreamBuilder(context);
  }

  Widget _theStreamBuilder(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseManager.getOrderedPostsCollection().snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return _listScaffold(snapshot.data?.docs);
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }

  Widget _listScaffold(List<QueryDocumentSnapshot<Object?>>? docs) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wasteagram - ${_getAndSetTotalWastedItems(docs)}')
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CameraFab(),
      body: Column(
        children: [
          Expanded(child: PostList(docs: docs)),
        ]
      )
    );
  }

  num _getAndSetTotalWastedItems(List<QueryDocumentSnapshot<Object?>>? docs) {
    num total = 0;

    docs?.forEach((doc) {
      total += doc['quantity'];
    });

    return total;
  }
}
