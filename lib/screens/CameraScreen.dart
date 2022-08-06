import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  File? image;
  final picker = ImagePicker();
  void getImage() async {

    // TODO: Add error handling if permissions denied? show gallery if no camera?
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile?.path != null) {
      image = File(pickedFile!.path);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    if (image == null) {
      return Center(
        child: ElevatedButton(
          child: const Text('Select Photo'),
          onPressed: () {
            getImage();
          },
        )
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(image!),
          const SizedBox(height: 40),
          ElevatedButton(
            child: const Text('Post it!'),
            onPressed: () {

            },
          )
        ]
      )
    );
  }

  Widget theStreamBuilder(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('nameOfCollection').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      // initialData:  // add this somehow?

        if (snapshot.hasData) {
          // or, instead of if -> switch(snapshot.connectionState) {
          // case ConnectionState.something: do something
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var post = snapshot.data!.docs[index];
              return ListTile(
                // post['nameOfField'] from Firestore
                leading: Text(post['weight'].toString()),
                title: Text(post['title']));
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      }
    );
  }

}
