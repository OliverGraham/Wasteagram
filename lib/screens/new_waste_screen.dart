import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/firebase/firebase_manager.dart';
import 'package:wasteagram/models/food_waste_post.dart';


// From Canvas

class NewWasteScreen extends StatefulWidget {

  const NewWasteScreen({Key? key}) : super(key: key);
  static const route = 'new_waste_screen';

  @override
  State<NewWasteScreen> createState() => _NewWasteScreenState();
}

class _NewWasteScreenState extends State<NewWasteScreen> {

  File? image;
  ImagePicker? picker;
  final formKey = GlobalKey<FormState>();
  int numberOfWastedItems = 0;

  /// open ImagePicker when navigating to this screen
  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
    setImageFromPicker();
  }

  @override
  Widget build(BuildContext context) {

    if (image == null) {
      return _loadingScreen();
    }

    return _screenWhenImage();
  }

  Widget _loadingScreen() {
    return  Center(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator()
        ],
      )
    );
  }

  Widget _screenWhenImage() {

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Add new Post')),
      resizeToAvoidBottomInset: false,
      body:
        Column(
        children: [
          const SizedBox(height: 10),
          Expanded(child: Image.file(image!)),
          const SizedBox(height: 40),
          _numberInputForm(),
          Expanded(child:
            Align(
              alignment: Alignment.bottomCenter,
              child:  _uploadButton()
            )
          )
        ]
      )
    );
  }

  Widget _uploadButton() {
    return Semantics(
      button: true,
      enabled: true,
      onTapHint: 'Upload image to cloud database',
      child:  ElevatedButton.icon(
        label: const Text(''),
        icon: const Icon(Icons.cloud_upload, size: 100),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(100),
        ),
        onPressed: () {
          uploadDataToFirestore();
        },
      ),
    );
  }

  Widget _numberInputForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters:  <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration:
              const InputDecoration(hintText: 'Number of wasted items'),
            validator: _validateNumber,
            onSaved: _savedNumberOfWastedItems
          )
        ]
      ),
    );
  }

  void _savedNumberOfWastedItems(dynamic amount) {
    numberOfWastedItems = int.parse(amount);
  }

  String? _validateNumber(dynamic value) {
    if (value == null) {
      return 'Please enter the number of wasted items';
    }
    return null;
  }

  /// use ImagePicker to choose file and then save that path's state
  void setImageFromPicker() async {
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final pickedFile = await picker?.pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
    setState(() {});
  }

  void uploadDataToFirestore() async {
    // final url = await getImage();
    // File imageFile = await getImageFromPicker();

    // final weight = DateTime.now().millisecondsSinceEpoch % 1000; // ?
    final DateTime time = DateTime.now();
    //final title = 'Title $weight';

    final String url =
    await FirebaseManager.saveImageAndReturnUrl(image, '$time.jpg');

    FirebaseManager.addPostDocument(FoodWastePost(
        date: time,
        imageURL: url,
        quantity: 100,
        latitude: 5.0,
        longitude: 10.5)
    );

    // TODO: navigate back to home screen
  }
}
