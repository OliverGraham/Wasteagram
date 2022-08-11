import 'package:flutter/material.dart';
//import 'package:wasteagram/screens/CameraScreen.dart';
//import 'package:wasteagram/screens/ShareLocationScreen.dart';
import 'package:wasteagram/screens/waste_list_screen.dart';
import 'package:wasteagram/screens/camera_screen.dart';
import 'package:wasteagram/screens/new_waste_screen.dart';
//import 'package:wasteagram/screens/camera_screen.dart';

// compute function, to run things in separate Isolate?

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  static final routes = {
    WasteListScreen.route: (context) => const WasteListScreen(),
    NewWasteScreen.route: (context) => const NewWasteScreen(),
  };

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  int numberOfWastedProducts = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: App.routes,
      home: const Scaffold(
        resizeToAvoidBottomInset: false,
        //body: ShareLocationScreen()
        body: NewWasteScreen()
      )
    );
  }
}
