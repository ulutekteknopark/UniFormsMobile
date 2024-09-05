import 'package:flutter/material.dart';
import '../models/form_model.dart';
import '../models/form_response_model.dart';

class TextFieldResponses extends StatelessWidget {
  final List<FormResponseModel> responses;
  final FormModel form;

  TextFieldResponses({required this.responses, required this.form});

  @override
  Widget build(BuildContext context) {
    final textFieldResponses = <String, List<String>>{};

    for (var response in responses) {
      response.responses.forEach((key, value) {
        final component = form.components.firstWhere((comp) => comp.id == key);
        if (value is String && component.type == 'text') {
          textFieldResponses.putIfAbsent(key, () => []).add(value);
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
        children: textFieldResponses.entries.map((entry) {
          final componentTitle = form.components.firstWhere((comp) => comp.id == entry.key).title;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Soru: $componentTitle',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                ...entry.value.map((response) => Text('- $response')).toList(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
