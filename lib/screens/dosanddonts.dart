import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widgets/app_drawer.dart';

class DoesandDonts extends StatelessWidget {
  static const routeName = '/does-and-donts';

  Widget doAndDont(String title, IconData iconData, Color color) {
    return Container(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 30,
              color: color,
            ),
          ),
          Icon(
            iconData,
            size: 30,
            color: color,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
    );
  }

  Widget pointTitle(String title) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
    );
  }

  Widget pointImage(String path) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 250,
      child: ClipRRect(
        child: Image.asset(
          'assets/images/$path',
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 5),
    );
  }

  Widget pointDescription(String description) {
    return Container(
      child: Text(
        description,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Do's and Dont's"),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            doAndDont(
              "Do's ",
              MdiIcons.shieldCheck,
              Color(0xFF1EB980),
            ),
            pointTitle('1. Hand Wash'),
            pointImage('hand-wash.jpg'),
            pointDescription(
                'Regular hand wash for 30 seconds will help you avoid germs or any kind of infection. Use soap or hand sanitizer for better results and do this every time you travel or touch anything.'),
            Divider(),
            pointTitle('2. Wear Mask Properly'),
            pointImage('wmp.jpg'),
            pointDescription(
                'Covering your mouth and nose while sneezing or when anyone next to coughs or sneezes can do you a lot better. Coronavirus usually spreads through cough and covering your nose and mouth will save you from this epidemic.'),
            Divider(),
            pointTitle('3. Consult A Doctor If Sick'),
            pointImage('consult-doctor.jpg'),
            pointDescription(
                'If you are suffering from a common cold, cough, nausea, vomiting, shortness of breath and fatigue make it a point to consult a doctor at the earliest. Any of these symptoms could be a sign that you are suffering from the virus.'),
            SizedBox(height: 10),
            doAndDont(
              "Dont's ",
              MdiIcons.closeOctagon,
              Theme.of(context).errorColor,
            ),
            pointTitle('1. Avoid Close Contact With Anyone'),
            pointImage('avoid-cc.jpg'),
            pointDescription(
                'Do not get close to anyone, especially touching or laughing closely. Also, use anti-pollution masks when out with friends or family. Avoid touching anyone and do not use the same utensils used by another. These simple non-touchy ways can do good until the outbreak comes to an end.'),
            Divider(),
            pointTitle('2. Do Not Spit'),
            pointImage('no-spitting.jpg'),
            pointDescription(
                'Spitting can increase the spread of the virus. Avoid spiting at in public and home. Also, avoid getting close to a sick person suffering from cold and cough.'),
            Divider(),
            pointTitle("3. Don't Panic, Take It Easy"),
            pointImage('dont-panic.jpg'),
            pointDescription(
                'Most often a state of fear can lead to taking wrong decisions and use of self-medication. All you need to keep in mind is hygiene i.e. regular hand wash, use of anti-pollution masks and consult a doctor if you are sick.'),
            Divider(),
          ],
        ),
      ),
    );
  }
}
