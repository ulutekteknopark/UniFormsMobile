import 'package:flutter/material.dart';
import 'form_component.dart';

class CheckBoxComponent extends FormComponent {
  @override
  final String id;
  String title;
  List<String> options;
  @override
  bool isRequired;

  CheckBoxComponent({
    required this.id,
    required this.title,
    this.options = const [],
    this.isRequired = false,
  });

  @override
  String get type => 'checkbox';

  @override
  Widget buildComponent({
    Function(dynamic)? onChanged,
    String initialValue = '',
    bool enabled = true,
  }) {
    return _CheckBoxComponentWidget(
      id: id,
      title: title,
      options: options,
      isRequired: isRequired,
      onChanged: onChanged,
      initialValue: initialValue,
      enabled: enabled,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'checkbox',
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

  static CheckBoxComponent fromJson(Map<String, dynamic> json) {
    return CheckBoxComponent(
      id: json['id'],
      title: json['title'],
      options: List<String>.from(json['options']),
      isRequired: json['isRequired'] ?? false,
    );
  }
}

class _CheckBoxComponentWidget extends StatefulWidget {
  final String id;
  final String title;
  final List<String> options;
  final bool isRequired;
  final Function(dynamic)? onChanged;
  final String initialValue;
  final bool enabled;

  _CheckBoxComponentWidget({
    required this.id,
    required this.title,
    required this.options,
    required this.isRequired,
    this.onChanged,
    this.initialValue = '',
    this.enabled = true,
  });

  @override
  __CheckBoxComponentWidgetState createState() =>
      __CheckBoxComponentWidgetState();
}

class __CheckBoxComponentWidgetState extends State<_CheckBoxComponentWidget> {
  late List<bool> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List<bool>.filled(widget.options.length, false);

    if (widget.initialValue.isNotEmpty) {
      List<String> selectedOptions = widget.initialValue.split(',');
      for (var option in selectedOptions) {
        int index = widget.options.indexOf(option);
        if (index != -1) {
          _selectedOptions[index] = true;
        }
      }
    }
  }

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
                      Checkbox(
                        value: _selectedOptions[index],
                        onChanged: widget.enabled
                            ? (bool? value) {
                          setState(() {
                            _selectedOptions[index] = value ?? false;
                          });

                          List<String> selectedOptions = [];
                          for (int i = 0; i < _selectedOptions.length; i++) {
                            if (_selectedOptions[i]) {
                              selectedOptions.add(widget.options[i]);
                            }
                          }
                          widget.onChanged?.call(selectedOptions);
                        }
                            : null,
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
                      fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
