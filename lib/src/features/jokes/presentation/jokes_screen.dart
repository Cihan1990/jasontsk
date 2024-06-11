import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({super.key});

  @override
  State<JokesScreen> createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  // State
  String joke = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(joke),
            OutlinedButton(
              onPressed: () async {
                //  api.chucknorris.io    /jokes/random
                final response =
                    await get(Uri.https('api.chucknorris.io', 'jokes/random'));

                // 1. JSON String in Variable speichern
                String jsonString = response.body;

                // 2. JSON String in Map umwandel
                Map<String, dynamic> m = jsonDecode(jsonString);

                // 3.
                setState(() {
                  joke = m["value"];
                });
              },
              child: const Text("Hole Witz!"),
            ),
          ],
        ),
      ),
    );
  }
}
