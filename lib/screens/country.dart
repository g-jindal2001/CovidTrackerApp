import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/data.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../providers/chartData.dart';

import '../widgets/card_country_page.dart';
import '../widgets/daily_cases_or_deaths_chart.dart';
import '../widgets/shimmer.dart';

class Country extends StatefulWidget {
  static const routeName = '/country';

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final countryNameData =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      final countryName = countryNameData['input'];
      try {
        Provider.of<Data>(context, listen: false)
            .loadAndUpdateCovidCountryData(countryName);

        final chart = Provider.of<ChartData>(context, listen: false);
        chart.fetchDailyCasesPlotData(countryName).then((_) => setState(() {
              _isLoading = false;
            }));

        chart.fetchDailyDeathsPlotData(countryName);
      } catch (error) {
        print(error.toString());
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refreshCountryData(BuildContext context, String country) async {
    await Provider.of<Data>(context, listen: false)
        .loadAndUpdateCovidCountryData(country);
  }

  void _getSizeOfWidget(Size size) {
    print(size.height);
    print(size.width);
  }

  @override
  Widget build(BuildContext context) {
    final countryNameData2 =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final countryName2 = countryNameData2['input'];
    //final bool countryBool = countryNameData2['oneTime'];
    final covidCountryData = Provider.of<Data>(context).data;
    final covidCountryChartData = Provider.of<ChartData>(context);
    final deviceSize = MediaQuery.of(context).size;
    final devicePadding = MediaQuery.of(context).padding;

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Covid-19 stats in $countryName2'),
          )
        : AppBar(
            title: Text('Covid-19 stats in $countryName2'),
          );

    final finalHeightExcludingAppBar =
        deviceSize.height - appBar.preferredSize.height - devicePadding.top;

    final content = ListView(
      children: [
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: finalHeightExcludingAppBar * 0.15,
                  child: CardCountryPage(
                    'Affected',
                    covidCountryData['countryCases'],
                    Colors.blue,
                  ),
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: Container(
                  height: finalHeightExcludingAppBar * 0.15,
                  child: CardCountryPage(
                    'Deaths',
                    covidCountryData['countryDeaths'],
                    Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: finalHeightExcludingAppBar * 0.15,
                  child: CardCountryPage(
                    'Recovered',
                    covidCountryData['countryRecovered'],
                    Colors.green,
                  ),
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: Container(
                  height: finalHeightExcludingAppBar * 0.15,
                  child: CardCountryPage(
                    'Active',
                    covidCountryData['countryActiveCases'],
                    Colors.orange,
                  ),
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Expanded(
                child: Container(
                  height: finalHeightExcludingAppBar * 0.15,
                  child: CardCountryPage(
                    'Serious',
                    covidCountryData['countrySerious'],
                    Colors.purple,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        _isLoading
            ? ShimmerObjects().shimmerCountryChart()
            : DailyNewCasesOrDeaths(
                'Daily new cases',
                covidCountryChartData.plotDailyCasesData,
                covidCountryChartData.maxCases,
                _getSizeOfWidget,
              ),
        SizedBox(height: 20),
        _isLoading
            ? ShimmerObjects().shimmerCountryChart()
            : DailyNewCasesOrDeaths(
                'Daily new deaths',
                covidCountryChartData.plotDailyDeathsData,
                covidCountryChartData.maxDeaths,
                _getSizeOfWidget,
              ),
      ],
    );

    //print(covidCountryChartData.plotDailyCasesData);

    final pageBody = SafeArea(
      child: RefreshIndicator(
        onRefresh: () => _refreshCountryData(context, countryName2),
        child: content,
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
          );
  }
}
