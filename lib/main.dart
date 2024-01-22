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
  Future<String>? duckFactFuture;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: FutureBuilder(
              future: duckFactFuture,
              builder: (context, snapshot) {
                String duckFact = "";
                if (snapshot.hasError) {
                  error = snapshot.error.toString();
                } else {
                  error = "";
                  duckFact = snapshot.data ?? "Keine Info bekommen";
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(duckFact),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () async {
                        duckFactFuture = getFact();
                        setState(() {});
                      },
                      child: const Text("Neue Info"),
                    ),
                    if (error.isNotEmpty) Text(error),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
