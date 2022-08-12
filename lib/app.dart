import 'package:flutter/material.dart';
import 'package:wasteagram/screens/waste_list_screen.dart';
import 'package:wasteagram/screens/new_waste_screen.dart';
import 'screens/waste_detail_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  static const title = 'Wasteagram';

  static final routes = {
    WasteListScreen.route: (context) => const WasteListScreen(),
    WasteDetailScreen.route: (context) => const WasteDetailScreen(),
    NewWasteScreen.route: (context) => const NewWasteScreen(),
  };

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: App.routes,
      home: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: WasteListScreen()
      )
    );
  }
}
