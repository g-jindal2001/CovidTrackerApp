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
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 5,
      ),
      child: ListTile(
        title: Text(
          titleText,
          style: TextStyle(
            fontSize: 25,
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
      height: 140,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}
