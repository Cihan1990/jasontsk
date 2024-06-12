import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String info = "";
  final String apiKey =
      '00b6a73e9dba96a3f2fc6d49f544deb0'; // Make sure this is your correct API key
  String lat = "54.34";
  String lon = "10.99";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(info),
            ),
            OutlinedButton(
              onPressed: () async {
                final response = await http.get(
                  Uri.https(
                    'api.openweathermap.org',
                    '/data/2.5/weather',
                    {
                      'lat': lat,
                      'lon': lon,
                      'appid': apiKey,
                    },
                  ),
                );
                if (response.statusCode == 200) {
                  String jsonString = response.body;
                  print(jsonString);
                  Map<String, dynamic> m = jsonDecode(jsonString);
                  setState(() {
                    info = m["weather"][0]["description"];
                  });
                } else {
                  setState(() {
                    info = "Failed to get weather data";
                  });
                }
              },
              child: const Text(
                "Get Weather",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
