import 'dart:convert';

import 'package:duck_facts_app/duck_fact.dart';
import 'package:http/http.dart';

class DuckFactRepository {
  final factUri =
      'https://03vpefsitf.execute-api.eu-west-1.amazonaws.com/prod/';

  // Holt das Textgeraffel aus dem Internet und gibt es zurück.
  Future<String> _getDataFromApi() async {
    final Response response = await get(Uri.parse(factUri));

    final String jsonString = response.body;

    return jsonString;
  }

  // Dekodiert das JSON und gibt die Info zurück.
  Future<DuckFact> getFact() async {
    final String jsonString = await _getDataFromApi();
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    final DuckFact newDuckFact = DuckFact.fromJson(jsonMap);

    return newDuckFact;
  }
}
