import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MainApp());
}

const factUri = 'https://03vpefsitf.execute-api.eu-west-1.amazonaws.com/prod/';

// Datenklasse, weil sie Daten speichert und hält.
class DuckFact {
  int feistynessRating;
  bool quack;
  String fact;

  DuckFact({
    required this.feistynessRating,
    required this.quack,
    required this.fact,
  });
}

// Holt das Textgeraffel aus dem Internet und gibt es zurück.
Future<String> getDataFromApi() async {
  final Response response = await get(Uri.parse(factUri));

  final String jsonString = response.body;

  return jsonString;
}

// Dekodiert das JSON und gibt die Info zurück.
Future<DuckFact> getFact() async {
  final String jsonString = await getDataFromApi();
  final Map<String, dynamic> jsonMap = json.decode(jsonString);

  final int feistynessRating = jsonMap['feistynessRating'];
  final bool quack = jsonMap['quack'];
  final String fact = jsonMap['fact'];

  final DuckFact newDuckFact = DuckFact(
    feistynessRating: feistynessRating,
    quack: quack,
    fact: fact,
  );

  return newDuckFact;
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  DuckFact? duckFact;

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
                Text(duckFact == null
                    ? 'Noch keine Info geholt.'
                    : duckFact?.fact ?? ""),
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
