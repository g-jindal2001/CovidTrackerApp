import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/helpers/helper_funtions.dart';

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class DailyNewCasesOrDeaths extends StatefulWidget {
  final String title;
  final List<FlSpot> points;
  final double maxNo;

  DailyNewCasesOrDeaths(this.title, this.points, this.maxNo);

  @override
  _DailyNewCasesOrDeathsState createState() => _DailyNewCasesOrDeathsState();
}

class _DailyNewCasesOrDeathsState extends State<DailyNewCasesOrDeaths> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            child: Text(widget.title),
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 11),
          ),
          AspectRatio(
            aspectRatio: 1.70,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Colors.black12,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 44, bottom: 12),
                child: LineChart(
                  dailyNewCasesOrDeathsChild(
                    widget.points,
                    widget.maxNo,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

LineChartData dailyNewCasesOrDeathsChild(
    List<FlSpot> plotpoints, double maxStat) {
  double maxValue = HelperFunctions().maxPossibleChartValue();
  String getBottomTitles(double value) {
    print('Chart value $value');
    if (value == maxValue / 4.0) {
      return HelperFunctions().getMonthAndYear(maxValue / 4.0);
    } else if (value == maxValue / 2.0) {
      return HelperFunctions().getMonthAndYear(maxValue / 2.0);
    } else if (value == (maxValue * 3) / 4.0) {
      return HelperFunctions().getMonthAndYear((maxValue * 3) / 4.0);
    }
    return '';
  }

  return LineChartData(
    gridData: FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        getTextStyles: (value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 11),
        getTitles: getBottomTitles,
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (value) => const TextStyle(
          color: Color(0xff67727d),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return HelperFunctions()
                  .condensedNumber(maxStat == null ? 0.0 : maxStat / 9.0);
            case 5:
              return HelperFunctions()
                  .condensedNumber(maxStat == null ? 0.0 : maxStat / 5.0);
            case 9:
              return HelperFunctions()
                  .condensedNumber(maxStat == null ? 0.0 : maxStat / 1.0);
          }
          return '';
        },
        reservedSize: 38,
        margin: 12,
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    minX: 0,
    maxX: plotpoints.length.toDouble(),
    minY: 0,
    maxY: 10,
    lineTouchData: LineTouchData(enabled: false),
    lineBarsData: [
      LineChartBarData(
        spots: plotpoints,
        isCurved: true,
        colors: gradientColors,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors:
              gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],
  );
}
