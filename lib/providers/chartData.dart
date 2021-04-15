import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../utils/helpers/scaling_factor_helper.dart';

class ChartData with ChangeNotifier {
  List<FlSpot> _plotDailyCasesData = [];
  List<FlSpot> _plotDailyDeathsData = [];

  List<FlSpot> get plotDailyCasesData {
    return [..._plotDailyCasesData];
  }

  List<FlSpot> get plotDailyDeathsData {
    return [..._plotDailyDeathsData];
  }

  Future<void> fetchDailyCasesPlotData(String country) async {
    List<double> newCases = [];
    List<DateTime> newCasesDates = [];
    List<double> newCasesKeys = [];
    double temp, maxNo, scaleFactor;

    final urlDailyCases = Uri.parse(
        'https://disease.sh/v3/covid-19/historical/$country?lastdays=all');

    try {
      final responseCases = await http.get(urlDailyCases);
      final extractedDailyCases = json.decode(responseCases.body)['timeline']
          ['cases'] as Map<String, dynamic>;

      extractedDailyCases.values.toList().asMap().forEach((key, value) {
        //Getting list of daily new cases for that country
        if (key == 0) {
          // for first iteration
          newCasesKeys.add(key.toDouble());
          newCases.add(double.parse(value.toString()));
        } else {
          newCasesKeys.add(key.toDouble());
          temp = double.parse(extractedDailyCases.values.toList().asMap()[key - 1].toString());//temp stores the amount of cases for yestreday
          newCases.add((value - temp));
        }
      });
      print(newCases.reduce(min));
      maxNo = newCases.reduce(max);//Get the highest number

      scaleFactor = ScalingFactorHelper().scaleFactor(maxNo);

      newCases = newCases.map((element) => element / scaleFactor).toList();

      extractedDailyCases.keys.forEach((key) {
        newCasesDates.add(DateFormat('M/d/yy').parse(key));
      });

      for (var i in List.generate(newCasesKeys.length, (index) => index)) {
        _plotDailyCasesData.add(
          FlSpot(
            newCasesKeys[i],
            newCases[i],
          ),
        );
      }
   
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchDailyDeathsPlotData(String country) async {
    List<double> newDeaths = [];
    List<DateTime> newDeathsDates = [];
    List<double> newDeathsKeys = [];
    double tempDeaths, maxNo, scaleFactor;

    final urlDailyDeaths = Uri.parse(
        'https://disease.sh/v3/covid-19/historical/$country?lastdays=all');

    try {
      final responseDeaths = await http.get(urlDailyDeaths);
      final extractedDailyDeaths = json.decode(responseDeaths.body)['timeline']
          ['deaths'] as Map<String, dynamic>;

      extractedDailyDeaths.values.toList().asMap().forEach((key, value) {
        //Getting list of daily new cases for that country
        if (key == 0) {
          // for first iteration
          newDeathsKeys.add(key.toDouble());
          newDeaths.add(double.parse(value.toString()));
        } else {
          newDeathsKeys.add(key.toDouble());
          tempDeaths = double.parse(extractedDailyDeaths.values.toList().asMap()[key - 1].toString());
          newDeaths.add((value - tempDeaths) / 1000.0);
        }
      });

      maxNo = newDeaths.reduce(max);

      scaleFactor = ScalingFactorHelper().scaleFactor(maxNo);

      newDeaths = newDeaths.map((element) => element / scaleFactor).toList();

      extractedDailyDeaths.keys.forEach((key) {
        newDeathsDates.add(DateFormat('M/d/yy').parse(key));
      });

      for (var i in List.generate(newDeathsKeys.length, (index) => index)) {
        _plotDailyDeathsData.add(
          FlSpot(
            newDeathsKeys[i],
            newDeaths[i],
          ),
        );
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
