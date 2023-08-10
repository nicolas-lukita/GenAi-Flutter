import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gen_ai_frontend/constants/colors.dart';
import 'package:gen_ai_frontend/helpers/formatter.dart';

final List<Color> pieColors = [
  assetChartColor1,
  assetChartColor2,
  assetChartColor3,
  assetChartColor4,
  assetChartColor5,
  assetChartColor6,
];

class AssetsChart extends StatefulWidget {
  final String data;
  const AssetsChart({super.key, required this.data});

  @override
  State<AssetsChart> createState() => _AssetsChartState();
}

class _AssetsChartState extends State<AssetsChart> {
  List<bool> touchedValueStates = [];
  int touchedIndex = -1;
  final List<PieChartSectionData> pieChartSelectionData = [];
  final List<PieMetaData> metaData = [];
  late List dataList;

  @override
  initState() {
    super.initState();
    pieChartSelectionData.clear();
    metaData.clear();
    Map<String, dynamic> jsonMap = json.decode(widget.data);
    dataList =
        jsonMap.entries.map((entry) => [entry.key, entry.value]).toList();

    dataList.asMap().forEach((index, value) {
      int colorIndex = index % pieColors.length;
      pieChartSelectionData.add(
        PieChartSectionData(
          color: pieColors[colorIndex],
          title: "${value[0]}\n\$${numberWithAbbreviation(value[1])}",
          value: value[1],
          showTitle: false,
          radius: 20,
        ),
      );
      metaData.add(PieMetaData(
          title: value[0],
          value: value[1],
          color: pieColors[colorIndex],
          isTouched: false));
      touchedValueStates.add(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "資產 Assets",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              "資產",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    height: 0.5,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Assets")
                          ],
                        ),
                      ),
                      PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          startDegreeOffset: -90,
                          sections: paiChartSelectionData(dataList),
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                        ),
                        swapAnimationDuration:
                            const Duration(milliseconds: 150),
                        swapAnimationCurve: Curves.linear,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: metaData.asMap().entries.map((entry) {
                      final index = entry.key;
                      final element = entry.value;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (touchedValueStates[index] == false) {
                              touchedValueStates =
                                  List.filled(touchedValueStates.length, false);
                              touchedValueStates[index] = true;
                            } else {
                              touchedValueStates[index] = false;
                            }
                          });
                        },
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                          color: element.color,
                                          shape: BoxShape.circle),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(element.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                Text(
                                    "${numberWithAbbreviation(element.value)} %",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> paiChartSelectionData(List dataList) {
    return List.generate(dataList.length, (i) {
      final isTouched = i == touchedIndex || touchedValueStates[i];
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 23.0 : 13.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return pieChartSelectionData[i].copyWith(
          showTitle: isTouched ? true : false,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: shadows,
          ));
    });
  }
}

class PieMetaData {
  final String title;
  final double value;
  final Color color;
  bool isTouched;

  PieMetaData(
      {required this.title,
      required this.value,
      required this.color,
      required this.isTouched});
}
