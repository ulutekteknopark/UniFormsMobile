import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';

class HorizontalBarChartWidget extends StatelessWidget {
  final Map<String, int> data;

  HorizontalBarChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      [
        charts.Series<MapEntry<String, int>, String>(
          id: 'RatingScale',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (MapEntry<String, int> entry, _) => entry.key,
          measureFn: (MapEntry<String, int> entry, _) => entry.value,
          data: data.entries.toList(),
        )
      ],
      animate: true,
      vertical: false,
      barGroupingType: charts.BarGroupingType.grouped,
      behaviors: [
        charts.ChartTitle('Yanıt Sayısı'),
        charts.ChartTitle(
          'Seçenekler',
          behaviorPosition: charts.BehaviorPosition.start,
        ),
      ],
    );
  }
}
