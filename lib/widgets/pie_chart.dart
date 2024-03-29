import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:untitled/widgets/indicator.dart';

class PieChartExpenses extends StatefulWidget {
  final double income;
  final double outcome;
  const PieChartExpenses(
      {Key? key, required this.income, required this.outcome})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartExpensesState();
}

class PieChartExpensesState extends State<PieChartExpenses> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: AppColor.bgColor1,
        margin: EdgeInsets.only(left: 16, top: 16),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
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
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(widget.income, widget.outcome)),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: AppColor.primaryColor,
                  text: 'Bulan ini',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: AppColor.secondaryColor,
                  text: 'Bulan kemarin',
                  isSquare: true,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(double income, double outcome) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColor.primaryColor,
            value: income == 0.0 ? 50 : income / 1000,
            title: '${income / 1000}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: AppColor.secondaryColor,
            value: outcome == 0.0 ? 50 : outcome / 1000,
            title: '${outcome / 1000}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
