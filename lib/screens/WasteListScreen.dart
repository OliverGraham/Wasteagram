import 'package:flutter/material.dart';
import '../components/camera_fab.dart';

class WasteListScreen extends StatelessWidget {
  const WasteListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram')),
      body: StreamBuilder(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Semantics(
          child: const CameraFab(),
          button: true,
          enabled: true,
          onTapHint: "Select an image",
        )

        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Container();
        },
      )

    );
  }
}
