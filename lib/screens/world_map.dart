import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/app_drawer.dart';

class WorldMapScreen extends StatelessWidget {
  static const routeName = '/world-map';

  @override
  Widget build(BuildContext context) {
    //final countryName = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Tracker'),
      ),
      drawer: AppDrawer(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://www.bing.com/covid/local/india',
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
        ),
      ),
    );
  }
}
