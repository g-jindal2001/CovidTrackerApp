import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class DailyNewCasesOrDeaths extends StatefulWidget {
  final String title;
  final List<FlSpot> points;

  DailyNewCasesOrDeaths(this.title, this.points);

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
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: LineChart(
                  dailyNewCasesChild(widget.points),
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

LineChartData dailyNewCasesChild(List<FlSpot> plotpoints) {
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
            fontSize: 16),
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return 'MAR';
            case 5:
              return 'JUN';
            case 8:
              return 'SEP';
          }
          return '';
        },
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
              return '10k';
            case 3:
              return '30k';
            case 5:
              return '50k';
          }
          return '';
        },
        reservedSize: 28,
        margin: 12,
      ),
    ),
    borderData: FlBorderData(
      show: false,
      // border: Border.all(color: const Color(0xff37434d), width: 1),
    ),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineTouchData: LineTouchData(enabled: false),
    lineBarsData: [
      LineChartBarData(
        spots: plotpoints,
        isCurved: true,
        colors: gradientColors,
        barWidth: 5,
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
