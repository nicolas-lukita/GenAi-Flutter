import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gen_ai_frontend/constants/colors.dart';
import 'package:gen_ai_frontend/helpers/formatter.dart';

class ComparisonChart extends StatefulWidget {
  final String data;
  const ComparisonChart({super.key, required this.data});

  @override
  State<ComparisonChart> createState() => _ComparisonChartState();
}

class _ComparisonChartState extends State<ComparisonChart> {
  List<bool> touchedValueStates = [false, false];
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jsonMap = json.decode(widget.data);
    List dataList =
        jsonMap.entries.map((entry) => [entry.key, entry.value]).toList();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                startDegreeOffset: -90,
                sections: paiChartSelectionData(dataList),
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
              ),
              swapAnimationDuration: const Duration(milliseconds: 150),
              swapAnimationCurve: Curves.linear,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (touchedValueStates[0] == false) {
                                  touchedValueStates = List.filled(
                                      touchedValueStates.length, false);
                                  touchedValueStates[0] = true;
                                } else {
                                  touchedValueStates[0] = false;
                                }
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      color: comparisonChartColor1,
                                      shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? MediaQuery.of(context).size.width * 0.2
                                      : MediaQuery.of(context).size.width * 0.6,
                                  child: Text(dataList[0][0],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                          Text(
                              "${numberWithAbbreviation(dataList[0][1])} / ${(dataList[0][1] / (dataList[0][1] + dataList[1][1]) * 100).toStringAsFixed(1)}%",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600))
                        ]),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (touchedValueStates[1] == false) {
                            touchedValueStates =
                                List.filled(touchedValueStates.length, false);
                            touchedValueStates[1] = true;
                          } else {
                            touchedValueStates[1] = false;
                          }
                        });
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      color: comparisonChartColor2,
                                      shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? MediaQuery.of(context).size.width * 0.2
                                      : MediaQuery.of(context).size.width * 0.6,
                                  child: Text(dataList[1][0],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                            Text(
                              "${numberWithAbbreviation((dataList[1][1]))} / ${(dataList[1][1] / (dataList[0][1] + dataList[1][1]) * 100).toStringAsFixed(1)}%",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            )
                          ]),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> paiChartSelectionData(List dataList) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex || touchedValueStates[i];
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 23.0 : 13.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: comparisonChartColor1,
            value: dataList[0][1],
            title:
                "${dataList[0][0]}\n${numberWithAbbreviation(dataList[0][1])}",
            showTitle: isTouched ? true : false,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: comparisonChartColor2,
            value: dataList[1][1],
            title:
                "${dataList[1][0]}\n${numberWithAbbreviation(dataList[1][1])}",
            showTitle: isTouched ? true : false,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
