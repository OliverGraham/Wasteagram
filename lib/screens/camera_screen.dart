import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/firebase/firebase_manager.dart';
import 'package:wasteagram/models/food_waste_post.dart';

// From Canvas

class CameraScreen extends StatefulWidget {

  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // File? image;
  final picker = ImagePicker();

  static const String _buttonText = 'Select photo and upload data';

/*
* Pick an image from the gallery, upload it to Firebase Storage and return
* the URL of the image in Firebase Storage.
*/
 /* Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    return FirebaseManager.getDownloadUrl(image, '${DateTime.now()}.jpg');
  }*/

  Future<File> getImageFromPicker() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return File(pickedFile!.path);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseManager.getPostsCollection().snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshotIsGood(snapshot)) {
            final List<QueryDocumentSnapshot<Object?>> docs =
                snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: listViewBuilder(context, docs)
                ),
                selectButton(),
              ],
            );
          }

          return Column(
            children: [
              const Center(child: CircularProgressIndicator()),
              selectButton(),
            ],
          );

        }
    );
  }

  Widget selectButton() {
    return ElevatedButton(
      child: const Text(_buttonText),
      onPressed: () {
        uploadData();
      },
    );
  }

  bool snapshotIsGood(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.hasData && snapshot.data!.docs.isNotEmpty;
  }

  Widget listViewBuilder(BuildContext context,
      List<QueryDocumentSnapshot<Object?>> docs
  ) {
    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        var post = docs[index];
        return ListTile(
            leading: Text(post['weight'].toString()),
            title: Text(post['title']));
      },
    );
  }

  void uploadData() async {
    // final url = await getImage();
    File imageFile = await getImageFromPicker();

    // final weight = DateTime.now().millisecondsSinceEpoch % 1000; // ?
    final DateTime time = DateTime.now();
    //final title = 'Title $weight';

    final String url =
      await FirebaseManager.saveImageAndReturnUrl(imageFile, '$time.jpg');

    FirebaseManager.addPostDocument(FoodWastePost(
        date: time,
        photoURL: url,
        quantity: 100,
        latitude: 5.0,
        longitude: 10.5)
    );

    /*FirebaseManager.getDownloadUrl(image, '$time.jpg');
    FirebaseFirestore.instance
        .collection('posts')
        .add({'weight': weight, 'title': title, 'url': url});*/
  }
}
