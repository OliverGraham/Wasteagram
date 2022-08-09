import 'package:flutter/material.dart';
import 'package:wasteagram/screens/CameraScreen.dart';
import 'package:wasteagram/screens/ShareLocationScreen.dart';

// compute function, to run things in separate Isolate?

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ShareLocationScreen()
        //body: CameraScreen()
      )
    );
  }
}
