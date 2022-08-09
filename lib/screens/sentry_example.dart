import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

const DSN_URL =
    'https://xxxxxxxxxxxxxxxxxxxxxxxxxxxx.ingest.sentry.io/xxxxxx';

Future<void> main() async {
  await SentryFlutter.init(
        (options) => options.dsn = DSN_URL,
    appRunner: () => runApp(App()),
  );
}

class App extends StatelessWidget {
  static Future<void> reportError(dynamic error, dynamic stackTrace) async {
    final sentryId =
    await Sentry.captureException(error, stackTrace: stackTrace);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Exmaple Screen'),
        ),
        body: Center(
            child: RaisedButton(
              child: Text('Throw an exception'),
              onPressed: () {
                throw StateError('Example Error!');
              },
            )));
  }
}
