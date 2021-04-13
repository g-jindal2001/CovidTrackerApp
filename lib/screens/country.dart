import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../providers/data.dart';

import '../widgets/card_country_page.dart';
import '../widgets/daily_cases_or_deaths_chart.dart';

class Country extends StatefulWidget {
  static const routeName = '/country';

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  var _isInit = true;
  List<FlSpot> pointsToBePlotted = [
    FlSpot(0, 3),
    FlSpot(2.6, 2),
    FlSpot(4.9, 5),
    FlSpot(6.8, 3.1),
    FlSpot(8, 4),
    FlSpot(9.5, 3),
    FlSpot(11, 4),
  ];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final countryName = ModalRoute.of(context).settings.arguments as String;
      try {
        Provider.of<Data>(context, listen: false)
            .loadAndUpdateCovidCountryData(countryName);
      } catch (error) {
        print(error.toString());
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshCountryData(BuildContext context, String country) async {
    await Provider.of<Data>(context, listen: false)
        .loadAndUpdateCovidCountryData(country);
  }

  @override
  Widget build(BuildContext context) {
    final countryName2 = ModalRoute.of(context).settings.arguments as String;
    final covidCountryData = Provider.of<Data>(context).data;

    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 stats in $countryName2'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshCountryData(context, countryName2),
        child: ListView(
          children: [
            SizedBox(height: 25),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CardCountryPage(
                      'Affected',
                      covidCountryData['countryCases'],
                      Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: CardCountryPage(
                      'Deaths',
                      covidCountryData['countryDeaths'],
                      Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: CardCountryPage(
                      'Recovered',
                      covidCountryData['countryRecovered'],
                      Colors.green,
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: CardCountryPage(
                      'Active',
                      covidCountryData['countryActiveCases'],
                      Colors.orange,
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: CardCountryPage(
                      'Serious',
                      covidCountryData['countrySerious'],
                      Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            DailyNewCasesOrDeaths(
              'Daily new cases',
              pointsToBePlotted,
            ),
            SizedBox(height: 24),
            DailyNewCasesOrDeaths(
              'Daily new deaths',
              pointsToBePlotted,
            ),
          ],
        ),
      ),
    );
  }
}
