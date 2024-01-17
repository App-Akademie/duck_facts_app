import 'package:duck_facts_app/duck_fact.dart';
import 'package:duck_facts_app/duck_fact_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  DuckFactRepository repository = DuckFactRepository();
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
                    duckFact = await repository.getFact();
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
