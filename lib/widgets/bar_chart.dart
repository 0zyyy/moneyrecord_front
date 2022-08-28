import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensesChart extends StatefulWidget {
  final List<String> tooltipWeeks;
  final List<String> weeks;
  final List<double> weeksValue;
  ExpensesChart(
      {Key? key,
      required this.tooltipWeeks,
      required this.weeks,
      required this.weeksValue})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ExpensesChartState();
}

class ExpensesChartState extends State<ExpensesChart> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final double width = 20;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final items = widget.weeksValue
        .mapIndexed((index, element) => element == 0.0
            ? makeGroupData(index, 0)
            : makeGroupData(index, element))
        .toList();
    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 20,
                    barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          fitInsideHorizontally: true,
                          tooltipBgColor: Colors.grey,
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            String weekDay;
                            switch (group.x.toInt()) {
                              case 0:
                                weekDay = widget.tooltipWeeks[0];
                                break;
                              case 1:
                                weekDay = widget.tooltipWeeks[1];
                                break;
                              case 2:
                                weekDay = widget.tooltipWeeks[2];
                                break;
                              case 3:
                                weekDay = widget.tooltipWeeks[3];
                                break;
                              case 4:
                                weekDay = widget.tooltipWeeks[4];
                                break;
                              case 5:
                                weekDay = widget.tooltipWeeks[5];
                                break;
                              case 6:
                                weekDay = widget.tooltipWeeks[6];
                                break;
                              default:
                                throw Error();
                            }
                            return BarTooltipItem(
                              weekDay + '\n',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: (rod.toY - 1).toString(),
                                  style: const TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        touchCallback: (FlTouchEvent event, response) {
                          if (response == null || response.spot == null) {
                            setState(() {
                              touchedGroupIndex = -1;
                              showingBarGroups = List.of(rawBarGroups);
                            });
                            return;
                          }

                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;

                          setState(() {
                            if (!event.isInterestedForInteractions) {
                              touchedGroupIndex = -1;
                              showingBarGroups = List.of(rawBarGroups);
                              return;
                            }
                            showingBarGroups = List.of(rawBarGroups);
                          });
                        }),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 42,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: 1,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '${widget.weeksValue.min}K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 20) {
      text = '${widget.weeksValue.max / 100}K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    Widget text = Text(
      widget.weeks[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        toY: y1,
        color: leftBarColor,
        width: width,
      ),
    ]);
  }
}
