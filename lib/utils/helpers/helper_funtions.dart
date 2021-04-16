import 'package:intl/intl.dart';
import 'package:basic_utils/basic_utils.dart';

class HelperFunctions {
  double scaleFactor(double number) {
    return number / 10.0;
  }

  Map<int, dynamic> copyOfMap(List<dynamic> inputList) {
    Map<int, dynamic> mapconvert;
    mapconvert = inputList.asMap().map((key, value) {
      return MapEntry(key, value);
    });
    return mapconvert;
  }

  String condensedNumber(double number) {
    if (number == null) {
      return '';
    }

    String result = NumberFormat.compact().format(number);
    if (result.contains('.') && result.contains("K")) {
      return result.replaceFirst(RegExp(r"\.[^]*"), "") + 'K';
    } else if (result.contains('.') && !result.contains("K")) {
      return double.parse(result).toStringAsFixed(0);
    }
    return result;
  }

  double maxPossibleChartValue() {
    int maxPossible;
    DateTime latestDate = DateTime.now();
    DateTime intialDate = DateTime(2020, 1, 22);

    int diff = latestDate.difference(intialDate).inDays;

    for (var i = diff - 79; i <= diff; i++) {
      if ((i / 4) % 20 == 0) {
        maxPossible = i;
      }
    }

    return maxPossible.toDouble();
  }

  String getMonthAndYear(double daysToAdd) {
    DateTime intialDate = DateTime(2020, 1, 22);
    DateTime finalDate = intialDate.add(Duration(days: daysToAdd.toInt()));
    return StringUtils.addCharAtPosition(
        DateFormat("MMM yy").format(finalDate).toUpperCase(), "’", 4);
  }
}
