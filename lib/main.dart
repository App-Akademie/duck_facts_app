import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MainApp());
}

const factUri = 'https://03vpefsitf.execute-api.eu-west-1.amazonaws.com/prod/';

// Holt das Textgeraffel aus dem Internet und gibt es zurück.
Future<String> getDataFromApi() async {
  final Response response = await get(Uri.parse(factUri));

  final String jsonString = response.body;

  return jsonString;
}

// Dekodiert das JSON und gibt die Info zurück.
Future<String> getFact() async {
  final String jsonString = await getDataFromApi();
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  final String fact = jsonMap['fact'];

  return fact;
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String duckFact = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(duckFact.isEmpty ? 'Noch keine Info geholt.' : duckFact),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () async {
                    duckFact = await getFact();
                    setState(() {});
                  },
                  child: const Text("Neue Info"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
