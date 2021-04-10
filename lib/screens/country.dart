import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/data.dart';

import '../widgets/card_home_page.dart';

class Country extends StatefulWidget {
  static const routeName = '/country';

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  var _isInit = true;

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
        title: Text('Covid-19 cases in $countryName2'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshCountryData(context, countryName2),
        child: ListView(
          children: [
            SizedBox(height:15),
            CardHomePage(
              'Cases',
              Icons.insights,
              covidCountryData['countryCases'],
              Colors.lightBlue,
            ),
            CardHomePage(
              'Active Cases',
              Icons.people,
              covidCountryData['countryActiveCases'],
              Colors.orange,
            ),
            CardHomePage(
              'Recovered',
              Icons.science,
              covidCountryData['countryRecovered'],
              Colors.green,
            ),
            CardHomePage(
              'Deaths',
              MdiIcons.skullCrossbones,
              covidCountryData['countryDeaths'],
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
