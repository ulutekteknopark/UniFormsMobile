import 'package:flutter/material.dart';
import 'form_component.dart';

class DropdownComponent extends FormComponent {
  @override
  final String id;
  String title;
  List<String> options;
  @override
  bool isRequired;

  DropdownComponent({
    required this.id,
    required this.title,
    this.options = const [],
    this.isRequired = false,
  });

  @override
  String get type => 'dropdown';

  @override
  Widget buildComponent({
    Function(dynamic)? onChanged,
    String initialValue = '',
    bool enabled = true,
  }) {
    return _DropdownComponentWidget(
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
      'type': 'dropdown',
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

  static DropdownComponent fromJson(Map<String, dynamic> json) {
    return DropdownComponent(
      id: json['id'],
      title: json['title'],
      options: List<String>.from(json['options']),
      isRequired: json['isRequired'] ?? false,
    );
  }
}

class _DropdownComponentWidget extends StatefulWidget {
  final String id;
  final String title;
  final List<String> options;
  final bool isRequired;
  final Function(dynamic)? onChanged;
  final String initialValue;
  final bool enabled;

  _DropdownComponentWidget({
    required this.id,
    required this.title,
    required this.options,
    required this.isRequired,
    this.onChanged,
    this.initialValue = '',
    this.enabled = true,
  });

  @override
  __DropdownComponentWidgetState createState() =>
      __DropdownComponentWidgetState();
}

class __DropdownComponentWidgetState extends State<_DropdownComponentWidget> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    // Set initial value
    _selectedValue = widget.initialValue.isNotEmpty && widget.options.contains(widget.initialValue)
        ? widget.initialValue
        : null;
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedValue,
                items: widget.options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: widget.enabled
                    ? (String? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                  widget.onChanged?.call(newValue ?? '');
                }
                    : null,
                underline: SizedBox(),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
                iconSize: 24,
                icon: Icon(Icons.arrow_drop_down, color: Colors.black87),
              ),
            ),
            SizedBox(height: 8),
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
