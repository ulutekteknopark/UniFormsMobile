import 'package:flutter/material.dart';
import '../models/form_component.dart';
import '../models/form_model.dart';
import '../models/form_response_model.dart';
import '../widgets/bar_chart_widget.dart';
import '../widgets/horizontal_bar_chart_widget.dart';
import '../widgets/pie_chart_widget.dart';

class ChartResponsesBuilder {
  final List<FormResponseModel> responses;
  final FormModel form;

  ChartResponsesBuilder({required this.responses, required this.form});

  List<Widget> build() {
    final chartsList = <Widget>[];
    final responsesMap = <String, Map<String, int>>{};

    for (var response in responses) {
      response.responses.forEach((key, value) {
        final component = form.components.firstWhere((comp) => comp.id == key);
        if (component.type != 'text') {
          if (value is List) {
            final options = List<String>.from(value);
            final map = responsesMap.putIfAbsent(key, () => {});
            for (var option in options) {
              map[option] = (map[option] ?? 0) + 1;
            }
          } else if (value is int || value is String) {
            final map = responsesMap.putIfAbsent(key, () => {});
            map[value.toString()] = (map[value.toString()] ?? 0) + 1;
          }
        }
      });
    }

    responsesMap.forEach((questionId, data) {
      final component = form.components.firstWhere((comp) => comp.id == questionId);
      final componentTitle = component.title;

      chartsList.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Soru: $componentTitle',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 200, child: _buildChartForComponent(component, data)),
            ],
          ),
        ),
      );
    });

    return chartsList;
  }

  Widget _buildChartForComponent(FormComponent component, Map<String, int> data) {
    if (component.type == 'checkbox') {
      return PieChartWidget(data: data);
    } else if (component.type == 'dropdown') {
      return BarChartWidget(data: data, isDropdown: true);
    } else if (component.type == 'radio') {
      return BarChartWidget(data: data, isDropdown: false);
    } else if (component.type == 'rating_scale') {
      return HorizontalBarChartWidget(data: data);
    } else {
      return Container();
    }
  }
}
