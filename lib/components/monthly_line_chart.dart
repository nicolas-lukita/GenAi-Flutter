import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gen_ai_frontend/constants/colors.dart';
import 'package:gen_ai_frontend/helpers/formatter.dart';

class MonthlyLineChart extends StatefulWidget {
  final String title;
  final String data;
  const MonthlyLineChart({super.key, required this.title, required this.data});

  @override
  State<MonthlyLineChart> createState() => _MonthlyLineChartState();
}

class _MonthlyLineChartState extends State<MonthlyLineChart> {
  List<Color> gradientColors = [
    Colors.white,
    splashColor,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jsonMap = json.decode(widget.data);
    List dataList =
        jsonMap.entries.map((entry) => [entry.key, entry.value]).toList();
    final List<dynamic> values =
        dataList.map<dynamic>((pair) => pair[1]).toList();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${numberWithCommas(values[values.length - 1])}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 34,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showAvg = !showAvg;
                    });
                  },
                  child: Text(
                    showAvg ? 'Hide Average' : "Show Average",
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          showAvg ? Colors.blue.withOpacity(0.5) : Colors.blue,
                    ),
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 1.70,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 18,
                    left: 12,
                    top: 24,
                    bottom: 12,
                  ),
                  child: LineChart(
                    mainData(dataList),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Jan', style: style);
        break;
      case 2:
        text = const Text('Feb', style: style);
        break;
      case 3:
        text = const Text('Mar', style: style);
        break;
      case 4:
        text = const Text('Apr', style: style);
        break;
      case 5:
        text = const Text('May', style: style);
        break;
      case 6:
        text = const Text('Jun', style: style);
        break;
      case 7:
        text = const Text('Jul', style: style);
        break;
      case 8:
        text = const Text('Aug', style: style);
        break;
      case 9:
        text = const Text('Sep', style: style);
        break;
      case 10:
        text = const Text('Oct', style: style);
        break;
      case 11:
        text = const Text('Nov', style: style);
        break;
      case 12:
        text = const Text('Dec', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
    );
    String text = numberWithAbbreviation(value);

    if (value == meta.max || value == meta.min) {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(List<dynamic> dataList) {
    final List<dynamic> values = dataList
        .map<dynamic>((pair) => double.parse(pair[1].toString()))
        .toList();
    final double average =
        setDecimal((values.reduce((a, b) => a + b) / values.length), 2);
    final double highest = values.reduce((a, b) => a > b ? a : b);
    final double lowest = values.reduce((a, b) => a < b ? a : b);

    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white.withOpacity(0.8),
          getTooltipItems: (List<LineBarSpot> lineBarSpot) {
            return lineBarSpot.map((lineBarSpot) {
              const textStyle = TextStyle(
                color: splashColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );
              return LineTooltipItem(
                '\$${numberWithAbbreviation(lineBarSpot.y)}',
                textStyle,
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: false,
        verticalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 3,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            interval: highest / 4,
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: double.parse(dataList[0][0]),
      maxX: double.parse(dataList[dataList.length - 1][0]),
      minY: lowest - average * 0.3,
      maxY: highest + average * 0.3,
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (var data in dataList)
              FlSpot(double.parse(data[0]), showAvg ? average : data[1])
          ],
          isCurved: false,
          color: splashColor,
          barWidth: 3,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: true,
            checkToShowDot: (spot, barData) =>
                spot.x == barData.spots[values.length - 1].x,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.2))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
