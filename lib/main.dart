import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/data.dart';
import './providers/chartData.dart';

import './screens/home_page.dart';
import './screens/dosanddonts.dart';
import './screens/country.dart';
import './screens/about.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Data(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChartData(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Covid-19 Tracker App',
          home: HomePage(),
          theme: ThemeData(
            brightness: Brightness.dark,
            backgroundColor: Color(0xFF2E2F36),
            accentColor: Colors.grey,
            //accentColor: Color(0xFF1EB980),
          ),
          routes: {
            DoesandDonts.routeName: (context) => DoesandDonts(),
            Country.routeName: (context) => Country(),
            About.routeName: (context) => About(),
          },
        ),
      ),
    );
  }
}
