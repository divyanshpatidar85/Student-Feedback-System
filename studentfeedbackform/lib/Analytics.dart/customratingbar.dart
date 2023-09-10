import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomRatingBar extends StatefulWidget {
  final List<int> ratingsCount;

  CustomRatingBar(this.ratingsCount);

  @override
  State<CustomRatingBar> createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  Timer? _timer;

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  LineChartData sampleData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, widget.ratingsCount[0] as double),
            FlSpot(1, widget.ratingsCount[1] as double),
            FlSpot(2, widget.ratingsCount[2] as double),
            FlSpot(3, widget.ratingsCount[3] as double),
            FlSpot(4, widget.ratingsCount[4] as double),
            FlSpot(5, widget.ratingsCount[5] as double),
          ],
          isCurved: true,
          // colors: [
          //   Colors.blue,
          // ],
          barWidth: 5,
        ),
      ],
      minY: 0,
      titlesData: const FlTitlesData(
          // leftTitles: SideTitles(showTitles: true),
          // bottomTitles: SideTitles(showTitles: true),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
        showTitles: true,
      ))),
      gridData: FlGridData(
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black12,
            strokeWidth: 1,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Center(
        child: AspectRatio(
      aspectRatio: 1.70,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: widget.ratingsCount
              .reduce((max, value) => max > value ? max : value)
              .toDouble(),
          barGroups: List.generate(6, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  fromY: widget.ratingsCount[index].toDouble(),
                  width: 20,
                  // colors: [Colors.blue],
                  borderRadius: BorderRadius.circular(8), toY: 0,
                ),
              ],
            );
          }),
          // titlesData: FlTitlesData(
          //   leftTitles: SideTitles(showTitles: true, interval: 1),
          //   bottomTitles: SideTitles(showTitles: true),
          // ),
          gridData: FlGridData(show: true),
        ),
      ),
    ));
  }

  void fun() {
    initState();
  }
}
