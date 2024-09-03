import 'package:flutter/material.dart';
import 'form_component.dart';

class MatrisComponent extends FormComponent {
  final String id;
  String headline;
  int rowNum;
  int colNum;
  Color headlineColor;
  Color matrisColor;
  bool isRequired;

  MatrisComponent({
    required this.id,
    required this.headline,
    this.rowNum = 2,
    this.colNum = 3,
    this.headlineColor = Colors.grey,
    this.matrisColor = Colors.white,
    this.isRequired = false,
  });

  @override
  Widget buildComponent({Function(String)? onChanged}) {
    return _MatrisComponentWidget(
      id: id,
      headline: headline,
      rowNum: rowNum,
      colNum: colNum,
      headlineColor: headlineColor,
      matrisColor: matrisColor,
      isRequired: isRequired,
      onChanged: onChanged,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'matris',
      'id': id,
      'headline': headline,
      'rowNum': rowNum,
      'colNum': colNum,
      'headlineColor': headlineColor.value,
      'matrisColor': matrisColor.value,
      'isRequired': isRequired,
    };
  }

  @override
  void updateFromJson(Map<String, dynamic> json) {
    headline = json['headline'] ?? headline;
    rowNum = json['rowNum'] ?? rowNum;
    colNum = json['colNum'] ?? colNum;
    headlineColor = Color(json['headlineColor'] ?? headlineColor.value);
    matrisColor = Color(json['matrisColor'] ?? matrisColor.value);
    isRequired = json['isRequired'] ?? isRequired;
  }

  static MatrisComponent fromJson(Map<String, dynamic> json) {
    return MatrisComponent(
      id: json['id'],
      headline: json['headline'],
      rowNum: json['rowNum'] ?? 2,
      colNum: json['colNum'] ?? 3,
      headlineColor: Color(json['headlineColor'] ?? Colors.grey.value),
      matrisColor: Color(json['matrisColor'] ?? Colors.white.value),
      isRequired: json['isRequired'] ?? false,
    );
  }
}

class _MatrisComponentWidget extends StatefulWidget {
  final String id;
  final String headline;
  final int rowNum;
  final int colNum;
  final Color headlineColor;
  final Color matrisColor;
  final bool isRequired;
  final Function(String)? onChanged;

  _MatrisComponentWidget({
    required this.id,
    required this.headline,
    required this.rowNum,
    required this.colNum,
    required this.headlineColor,
    required this.matrisColor,
    required this.isRequired,
    this.onChanged,
  });

  @override
  __MatrisComponentWidgetState createState() => __MatrisComponentWidgetState();
}

class __MatrisComponentWidgetState extends State<_MatrisComponentWidget> {
  List<List<TextEditingController>> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.rowNum,
      (_) => List.generate(widget.colNum, (_) => TextEditingController()),
    );
  }

  @override
  void dispose() {
    for (var row in _controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: widget.matrisColor,
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
              widget.headline,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: widget.headlineColor,
              ),
            ),
            SizedBox(height: 8),
            Table(
              border: TableBorder.all(color: Colors.grey),
              children: List.generate(widget.rowNum, (rowIndex) {
                return TableRow(
                  children: List.generate(widget.colNum, (colIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controllers[rowIndex][colIndex],
                        onChanged: (value) {
                          widget.onChanged?.call(value);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    );
                  }),
                );
              }),
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
