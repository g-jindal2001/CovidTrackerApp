import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/app_drawer.dart';

class About extends StatelessWidget {
  static const routeName = '/about';

  Widget buildCreditPoint(
      String title, String url, BuildContext ctx, int number) {
    return Row(
      children: [
        Container(
          child: Text(
            '$number.',
            style: TextStyle(fontSize: 16),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10),
        ),
        Expanded(
          child: Container(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
              ),
              softWrap: true,
            ),
            margin: EdgeInsets.only(left: 10),
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(MdiIcons.arrowTopRight),
            onPressed: () => {
              showDialog(
                context: ctx,
                builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text(
                      'This will navigate you to the site $url in your browser'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        launchURL(url);
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Yes'),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text('No'),
                    ),
                  ],
                ),
              ),
            },
          ),
          margin: EdgeInsets.only(
            bottom: 10,
            right: 5,
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }

  launchURL(String givenUrl) async {
    if (await canLaunch(givenUrl)) {
      await launch(givenUrl);
    } else {
      throw 'Could not launch $givenUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                  radius: 50.0,
                ),
                margin: EdgeInsets.only(top:25, bottom:25, left:25),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Hi! My name is Geetansh Jindal and I am a second-year CSE student at Maharashtra Institute of Technology',
                    style: TextStyle(fontSize: 16),
                  ),
                  margin: EdgeInsets.all(25),
                ),
              ),
            ],
          ),
          Divider(),
          Container(
            child: Text(
              'Thanks to the websites Freepik and Pexels for providing the images in this app',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            alignment: Alignment.center,
          ),
          buildCreditPoint(
            'Hand vector created by brgfx - www.freepik.com',
            'https://www.freepik.com/vectors/hand',
            context,
            1,
          ),
          Divider(),
          buildCreditPoint(
            'Infographic vector created by freepik - www.freepik.com',
            'https://www.freepik.com/vectors/infographic',
            context,
            2,
          ),
          Divider(),
          buildCreditPoint(
            'Computer vector created by upklyak - www.freepik.com',
            'https://www.freepik.com/vectors/computer',
            context,
            3,
          ),
          Divider(),
          buildCreditPoint(
            'Kids vector created by studiogstock - www.freepik.com',
            'https://www.freepik.com/vectors/kids',
            context,
            4,
          ),
          Divider(),
          buildCreditPoint(
            'Infographic vector created by freepik - www.freepik.com',
            'https://www.freepik.com/vectors/infographic',
            context,
            5,
          ),
          Divider(),
          buildCreditPoint(
            'Photo by Markus Spiske from Pexels',
            'https://www.pexels.com/photo/don-t-panic-text-on-toilet-paper-3991794/',
            context,
            6,
          ),
          Divider(),
        ],
      ),
    );
  }
}
