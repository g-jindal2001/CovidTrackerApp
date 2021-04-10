import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Data with ChangeNotifier {
  Map<String, String> _data = {
    'cases': '',
    'active_cases': '',
    'recovered': '',
    'deaths': '',
  };

  Map<String, String> get data {
    return {..._data};
  }

  Future<void> loadAndUpdateCoviddata() async {
    const url =
        'https://disease.sh/v3/covid-19/all?yesterday=false&twoDaysAgo=false';
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      _data['cases'] = extractedData['cases'].toString();
      _data['active_cases'] = extractedData['active'].toString();
      _data['recovered'] = extractedData['recovered'].toString();
      _data['deaths'] = extractedData['deaths'].toString();

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
