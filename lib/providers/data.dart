import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Data with ChangeNotifier {
  Map<String, String> _data = {
    'cases': '',
    'activeCases': '',
    'recovered': '',
    'deaths': '',
    'countryCases': '',
    'countryActiveCases': '',
    'countryRecovered': '',
    'countryDeaths': '',
    'countrySerious': '',
  };

  Map<String, String> get data {
    return {..._data};
  }

  Future<void> loadAndUpdateCoviddata() async {
    final url = Uri.parse(
        'https://disease.sh/v3/covid-19/all?yesterday=false&twoDaysAgo=false');

    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      _data['cases'] = extractedData['cases'].toString();
      _data['activeCases'] = extractedData['active'].toString();
      _data['recovered'] = extractedData['recovered'].toString();
      _data['deaths'] = extractedData['deaths'].toString();

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> loadAndUpdateCovidCountryData(String country) async {
    final countryUrl = Uri.parse(
        'https://disease.sh/v3/covid-19/countries/$country?yesterday=false&twoDaysAgo=false&strict=true');

    try {
      final responseCountry = await http.get(countryUrl);

      if (responseCountry.statusCode == 200) {
        print(json.decode(responseCountry.body));

        final countryExtractedData =
            json.decode(responseCountry.body) as Map<String, dynamic>;

        _data['countryCases'] = countryExtractedData['cases'].toString();
        _data['countryActiveCases'] = countryExtractedData['active'].toString();
        _data['countryRecovered'] =
            countryExtractedData['recovered'].toString();
        _data['countryDeaths'] = countryExtractedData['deaths'].toString();
        _data['countrySerious'] = countryExtractedData['critical'].toString();
      } else {
        throw ("Country name does not exist");
      }

      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
