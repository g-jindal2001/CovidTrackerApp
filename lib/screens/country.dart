import 'package:flutter/material.dart';
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
    if(_isInit) {
      final countryName = ModalRoute.of(context).settings.arguments as String;
      try {
        Provider.of<Data>(context, listen: false).loadAndUpdateCovidCountryData(countryName);
      } catch (error) {
        print(error.toString());
      }
      
    }

    _isInit = false;
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    final countryName2 = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 cases in $countryName2'),
      ),
      body: CardHomePage(
        'Cases',
        Icons.insights,
        '13443435',
        Colors.lightBlue,
      ),
    );
  }
}
