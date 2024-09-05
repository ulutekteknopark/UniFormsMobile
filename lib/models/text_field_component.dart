import 'package:flutter/material.dart';
import 'form_component.dart';

class TextFieldComponent extends FormComponent {
  @override
  final String id;
  String title;
  @override
  bool isRequired;

  TextFieldComponent({
    required this.id,
    required this.title,
    this.isRequired = false,
  });

  @override
  String get type => 'text';

  @override
  Widget buildComponent({
    Function(dynamic)? onChanged,
    String initialValue = '',
    bool enabled = true,
  }) {
    return _TextFieldComponentWidget(
      id: id,
      title: title,
      isRequired: isRequired,
      onChanged: onChanged,
      initialValue: initialValue,
      enabled: enabled,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'text',
      'id': id,
      'title': title,
      'isRequired': isRequired,
    };
  }

  @override
  void updateFromJson(Map<String, dynamic> json) {
    title = json['title'] ?? title;
    isRequired = json['isRequired'] ?? isRequired;
  }

  static TextFieldComponent fromJson(Map<String, dynamic> json) {
    return TextFieldComponent(
      id: json['id'],
      title: json['title'],
      isRequired: json['isRequired'] ?? false,
    );
  }
}

class _TextFieldComponentWidget extends StatefulWidget {
  final String id;
  final String title;
  final bool isRequired;
  final Function(dynamic)? onChanged;
  final String initialValue;
  final bool enabled;

  _TextFieldComponentWidget({
    required this.id,
    required this.title,
    required this.isRequired,
    this.onChanged,
    this.initialValue = '',
    this.enabled = true,
  });

  @override
  __TextFieldComponentWidgetState createState() =>
      __TextFieldComponentWidgetState();
}

class __TextFieldComponentWidgetState
    extends State<_TextFieldComponentWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  hintText: 'Cevabınızı buraya yazın...',
                  border: InputBorder.none,
                ),
                onChanged: widget.enabled
                    ? (String value) {
                  widget.onChanged?.call(value);
                }
                    : null,
                enabled: widget.enabled,
              ),
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
