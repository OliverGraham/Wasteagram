import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Lat", style: Theme.of(context).textTheme.displayLarge),
          Text("Long", style: Theme.of(context).textTheme.displayLarge),
          ElevatedButton(onPressed: () {}, child: const Text('Share'))
        ]
      ),
    );
  }
}
