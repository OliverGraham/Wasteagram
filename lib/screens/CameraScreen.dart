import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  void fireStorePicture() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile?.path != null) {
      image = File(pickedFile!.path);
    }

    // give child() a unique file key-string
    // use timestamp in name?
    // or
    // Path.basename(image?.path)
    final storage = FirebaseStorage.instance.ref();
    final storageReference = storage.child(
      'storage_reference_some_crazy_name'
    );
    try {
      await storageReference.putFile(image!);
    } catch (e) {
      print(e);
    }

    final url = await storageReference.getDownloadURL();
    print(url);
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
                fireStorePicture();
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

          return Column(
            children: [
              Expanded(
                child:
                ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];
                    return ListTile(
                      // post['nameOfField'] from Firestore
                        leading: Text(post['weight'].toString()),
                        title: Text(post['title']));
                  },
                )
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('posts').add({
                      'key': 222,
                      'thiscan': 'be a map'
                    });
                  },
                  child: const Text('Send Data to Firestore')
              )
            ]
          );

        }

        return const Center(child: CircularProgressIndicator());
      }
    );
  }

}
