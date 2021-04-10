import 'package:flutter/material.dart';

class Country extends StatelessWidget {
  static const routeName = '/country';


  @override
  Widget build(BuildContext context) {
    final countryName = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 cases in $countryName'),
      ),
    );
  }
}
