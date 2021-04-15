import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/data.dart';
import '../providers/chartData.dart';

import '../widgets/card_country_page.dart';
import '../widgets/daily_cases_or_deaths_chart.dart';

class Country extends StatefulWidget {
  static const routeName = '/country';

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  var _isInit = true;
  static const List<String> casesList = ['10k', '30k', '50k',];
  static const List<String> deathsList = ['1k', '3k', '5k',];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final countryName = ModalRoute.of(context).settings.arguments as String;
      try {
        Provider.of<Data>(context, listen: false)
            .loadAndUpdateCovidCountryData(countryName);

        final chart = Provider.of<ChartData>(context, listen: false);
        chart.fetchDailyCasesPlotData(countryName);
        chart.fetchDailyDeathsPlotData(countryName);
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
    final covidCountryChartData = Provider.of<ChartData>(context);

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
              covidCountryChartData.plotDailyCasesData,
              casesList,
            ),
            SizedBox(height: 24),
            DailyNewCasesOrDeaths(
              'Daily new deaths',
              covidCountryChartData.plotDailyDeathsData,
              deathsList,
            ),
          ],
        ),
      ),
    );
  }
}
