import 'package:flutter/material.dart';

import '../screens/dosanddonts.dart';
import '../screens/about.dart';
import '../screens/world_map.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Covid-19 Tracker app'),//Icons.clean_hands, Icons.coronavirus, Icons.flaky, Icons.people, Icons.sanitizer, Icons.science, Icons.soap, Icons.wash
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.coronavirus),
            title: Text("Overall Stats"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.map),
            title: Text("World Map"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(WorldMapScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text("Do's and Dont's"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(DoesandDonts.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("About"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(About.routeName);
            },
          ),
        ],
      ),
    );
  }
}
