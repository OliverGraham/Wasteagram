import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/models/food_waste_post.dart';

class FirebaseManager {

  static final _storage = FirebaseStorage.instance.ref();
  static final _fireStore = FirebaseFirestore.instance;
  static const _posts = 'posts';

  static Query<FoodWastePost> getOrderedPostsCollection() {
    return _fireStore.collection(_posts).orderBy('date', descending: true)
        .withConverter<FoodWastePost>(
        fromFirestore: (snapshot, _) => FoodWastePost.fromJson(snapshot.data()!),
        toFirestore: (foodWastePost, _) => foodWastePost.toJson(),
    );
  }

  static DocumentReference<FoodWastePost> getPostDocument(String documentId) {
    return _fireStore.collection(_posts).doc(documentId)
        .withConverter<FoodWastePost>(
        fromFirestore: (snapshot, _) => FoodWastePost.fromJson(snapshot.data()!),
    toFirestore: (foodWastePost, _) => foodWastePost.toJson(),
    );
  }

  static void addPostDocument(FoodWastePost post) {
    _getPostsCollection().add(post);
  }

  static CollectionReference<FoodWastePost> _getPostsCollection() {
    return _fireStore.collection(_posts)
        .withConverter<FoodWastePost>(
      fromFirestore: (snapshot, _) => FoodWastePost.fromJson(snapshot.data()!),
      toFirestore: (foodWastePost, _) => foodWastePost.toJson(),
    );
  }

  static Future<String> saveImageAndReturnUrl(File? image, String name) async {
    Reference storageReference = _storage.child(name);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }

}