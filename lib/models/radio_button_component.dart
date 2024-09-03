import 'package:flutter/material.dart';
import 'form_component.dart';

class RadioButtonComponent extends FormComponent {
  final String id;
  String title;
  List<String> options;
  bool isRequired;

  RadioButtonComponent({
    required this.id,
    required this.title,
    this.options = const [],
    this.isRequired = false,
  });

  @override
  Widget buildComponent({Function(String)? onChanged}) {
    return _RadioButtonComponentWidget(
      id: id,
      title: title,
      options: options,
      isRequired: isRequired,
      onChanged: onChanged,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'radio',
      'id': id,
      'title': title,
      'options': options,
      'isRequired': isRequired,
    };
  }

  @override
  void updateFromJson(Map<String, dynamic> json) {
    title = json['title'] ?? title;
    options = List<String>.from(json['options'] ?? options);
    isRequired = json['isRequired'] ?? isRequired;
  }

  static RadioButtonComponent fromJson(Map<String, dynamic> json) {
    return RadioButtonComponent(
      id: json['id'],
      title: json['title'],
      options: List<String>.from(json['options']),
      isRequired: json['isRequired'] ?? false,
    );
  }
}

class _RadioButtonComponentWidget extends StatefulWidget {
  final String id;
  final String title;
  final List<String> options;
  final bool isRequired;
  final Function(String)? onChanged;

  _RadioButtonComponentWidget({
    required this.id,
    required this.title,
    required this.options,
    required this.isRequired,
    this.onChanged,
  });

  @override
  __RadioButtonComponentWidgetState createState() =>
      __RadioButtonComponentWidgetState();
}

class __RadioButtonComponentWidgetState
    extends State<_RadioButtonComponentWidget> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.blueGrey[800],
              ),
            ),
            SizedBox(height: 8),
            Column(
              children: widget.options.asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: index,
                        groupValue: _selectedValue,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedValue = value;
                          });
                          widget.onChanged?.call(option);
                        },
                      ),
                      Expanded(
                        child: Text(
                          option,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            if (widget.isRequired)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '* Bu alan zorunludur',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
