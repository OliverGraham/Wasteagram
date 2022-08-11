import 'package:flutter/material.dart';
import 'package:wasteagram/screens/new_waste_screen.dart';

class CameraFab extends StatelessWidget {
  const CameraFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.photo_camera_outlined),
      onPressed: () {
        Navigator.of(context).pushNamed(NewWasteScreen.route);
    });
  }
}
