import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  final Map<String, int> data;
  final bool isDropdown;

  BarChartWidget({required this.data, required this.isDropdown});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      [
        charts.Series<MapEntry<String, int>, String>(
          id: isDropdown ? 'DropdownResponses' : 'RadioResponses',
          colorFn: (_, __) => isDropdown
              ? charts.MaterialPalette.red.shadeDefault
              : charts.MaterialPalette.blue.shadeDefault,
          domainFn: (MapEntry<String, int> entry, _) => entry.key,
          measureFn: (MapEntry<String, int> entry, _) => entry.value,
          data: data.entries.toList(),
        )
      ],
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.grouped,
        maxBarWidthPx: 50,
      ),
      behaviors: [
        charts.ChartTitle(
          'Yanıt Sayısı',
          behaviorPosition: charts.BehaviorPosition.start,
        ),
        charts.ChartTitle(
          'Seçenekler',
          behaviorPosition: charts.BehaviorPosition.bottom,
        ),
      ],
    );
  }
}
