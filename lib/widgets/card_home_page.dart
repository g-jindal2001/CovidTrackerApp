import 'package:flutter/material.dart';

class CardHomePage extends StatelessWidget {
  final String titleText;
  final IconData iconData;
  final String number;
  final Color color;

  CardHomePage(this.titleText, this.iconData, this.number, this.color);

  final RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  final Function mathFunc = (Match match) => '${match[1]},';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: constraints.maxHeight * 0.08,
          horizontal: 5,
        ),
        child: ListTile(
          title: Text(
            titleText,
            style: TextStyle(
              fontSize: 20,//font size can be small on certain devices and too large on other devices(TODO)
              color: color,
            ),
          ),
          subtitle: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 6,
                ),
                Icon(
                  iconData,
                  size: 45,
                  color: color,
                ),
              ],
            ),
            alignment: Alignment.centerLeft,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number.replaceAllMapped(reg, mathFunc),
                style: TextStyle(
                  fontSize: 23,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black12,
        ),
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      );
    });
  }
}
