// Name:        Oliver Graham
// Email:       olivergraham916@gmail.com / grahamol@oregonstate.edu
// Course:      CS492 / Summer 2022
// Description: Project 5 "Wasteagram"


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  runApp(const App());
}
