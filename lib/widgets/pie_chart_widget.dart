import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, int> data;

  PieChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: data.entries.map((entry) {
            return PieChartSectionData(
              value: entry.value.toDouble(),
              title: '${entry.key}: ${entry.value}',
              color: Colors.primaries[data.keys.toList().indexOf(entry.key) % Colors.primaries.length],
              radius: 60,
              titleStyle: TextStyle(fontSize: 14, color: Colors.white),
              showTitle: true,
            );
          }).toList(),
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}
