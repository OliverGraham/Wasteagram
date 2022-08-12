import 'dart:io';
import 'package:flutter/material.dart';

class ChosenImage extends StatelessWidget {

  final File? imageFile;
  final String? imageURL;

  const ChosenImage({
    this.imageFile,
    this.imageURL,
    Key? key}
  ) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Image? image;

    if (imageFile != null) {
      image = Image.file(imageFile!, height: 375);
    } else {
      image = Image.network(imageURL!, height: 425);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
      child: Semantics(
        hint: 'Picture taken, or chosen from gallery',
        child: image
      )
    );
  }
}
