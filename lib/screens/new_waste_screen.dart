import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/components/new_waste_form.dart';
import 'package:wasteagram/firebase/firebase_manager.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:location/location.dart';
import '../utils/location_manager.dart';

class NewWasteScreen extends StatefulWidget {

  const NewWasteScreen({Key? key}) : super(key: key);
  static const route = 'new_waste_screen';

  @override
  State<NewWasteScreen> createState() => _NewWasteScreenState();
}

class _NewWasteScreenState extends State<NewWasteScreen> {

  LocationManager locationManager = LocationManager.getInstance();
  final formKey = GlobalKey<FormState>();
  int numberOfWastedItems = -1;
  ImagePicker? picker;
  File? image;


  /// open ImagePicker when navigating to this screen
  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
    _setImageFromPicker();
  }

  @override
  Widget build(BuildContext context) {

    if (image == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Add new Post')),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          _chosenImage(),
          const NewWasteForm(),
          _uploadButton()
        ]
      )
    );
  }

  Widget _chosenImage() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
        child: Image.file(image!, height: 375)
    );
  }

  Widget _uploadButton() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Semantics(
          button: true,
          enabled: true,
          onTapHint: 'Upload image to cloud database',
          child: ElevatedButton.icon(
            label: const Text(''),
            icon: const Icon(Icons.cloud_upload, size: 100),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(10),
            ),
            onPressed: () {
              _uploadDataToFirestore();
            },
          )
        )
      )
    );
  }

  /// use ImagePicker to choose file and then save that path's state
  void _setImageFromPicker() async {
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final pickedFile = await picker?.pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
    setState(() {});
  }

  /// Save form state and upload to Firestore.
  /// Show error message if necessary.
  void _uploadDataToFirestore() async {
    if (!NewWasteForm.isFormValid()) {
      return;
    }
    NewWasteForm.saveForm();
    _getInfoAndSave(NewWasteForm.getNumberOfWastedItems());
    Navigator.of(context).pop();
  }

  /// Save time, image to Storage and get location, and save to Firestore
  void _getInfoAndSave(int numberOfWastedItems) async {
    final time = DateTime.now();
    final String url =
        await FirebaseManager.saveImageAndReturnUrl(image, '$time.jpg');

    LocationData? locationData = await locationManager.getCurrentLocation();

    FirebaseManager.addPostDocument(
      FoodWastePost(
        date: time,
        imageURL: url,
        quantity: numberOfWastedItems,
        latitude: locationData?.latitude,
        longitude: locationData?.longitude
      )
    );
  }
}
