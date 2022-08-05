import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class RemoteDataBuilderScreen extends StatefulWidget {
  const RemoteDataBuilderScreen({Key? key}) : super(key: key);

  static final url = Uri.parse('https://swapi.dev/api/people/3');

  @override
  State<RemoteDataBuilderScreen> createState() => _RemoteDataBuilderScreen();
}

class _RemoteDataBuilderScreen extends State<RemoteDataBuilderScreen> {
  Future<http.Response> apiResponse = http.get(RemoteDataBuilderScreen.url);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiResponse,
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          Widget child;
          if (snapshot.hasData) {
            Character character =
            Character.fromJSON(jsonDecode(snapshot.data!.body));
            child = Text(character.name);
          } else {
            // else if (snapshot.hasError)
            child = const CircularProgressIndicator();
          }
          return Center(child: child);
        });
  }
}
