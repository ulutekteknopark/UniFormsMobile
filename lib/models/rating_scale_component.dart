import 'package:flutter/material.dart';
import 'form_component.dart';

class RatingScaleComponent extends FormComponent {
  final String id;
  String title;
  String startLabel;
  String endLabel;
  int numberOfOptions;
  bool isRequired;

  RatingScaleComponent({
    required this.id,
    required this.title,
    this.startLabel = '',
    this.endLabel = '',
    this.numberOfOptions = 5,
    this.isRequired = false,
  });

  @override
  Widget buildComponent({Function(String)? onChanged}) {
    return _RatingScaleComponentWidget(
      id: id,
      title: title,
      startLabel: startLabel,
      endLabel: endLabel,
      numberOfOptions: numberOfOptions,
      isRequired: isRequired,
      onChanged: onChanged,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'rating_scale',
      'id': id,
      'title': title,
      'startLabel': startLabel,
      'endLabel': endLabel,
      'numberOfOptions': numberOfOptions,
      'isRequired': isRequired,
    };
  }

  @override
  void updateFromJson(Map<String, dynamic> json) {
    title = json['title'] ?? title;
    startLabel = json['startLabel'] ?? startLabel;
    endLabel = json['endLabel'] ?? endLabel;
    numberOfOptions = json['numberOfOptions'] ?? numberOfOptions;
    isRequired = json['isRequired'] ?? isRequired;
  }

  static RatingScaleComponent fromJson(Map<String, dynamic> json) {
    return RatingScaleComponent(
      id: json['id'],
      title: json['title'],
      startLabel: json['startLabel'] ?? '',
      endLabel: json['endLabel'] ?? '',
      numberOfOptions: json['numberOfOptions'] ?? 5,
      isRequired: json['isRequired'] ?? false,
    );
  }
}

class _RatingScaleComponentWidget extends StatefulWidget {
  final String id;
  final String title;
  final String startLabel;
  final String endLabel;
  final int numberOfOptions;
  final bool isRequired;
  final Function(String)? onChanged;

  _RatingScaleComponentWidget({
    required this.id,
    required this.title,
    required this.startLabel,
    required this.endLabel,
    required this.numberOfOptions,
    required this.isRequired,
    this.onChanged,
  });

  @override
  __RatingScaleComponentWidgetState createState() =>
      __RatingScaleComponentWidgetState();
}

class __RatingScaleComponentWidgetState
    extends State<_RatingScaleComponentWidget> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.startLabel),
                Text(widget.endLabel),
              ],
            ),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: Colors.blue,
                inactiveTrackColor: Colors.grey,
                thumbColor: Colors.blue,
                overlayColor: Colors.blue.withOpacity(0.2),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                valueIndicatorColor: Colors.blue,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Slider(
                value: _selectedValue?.toDouble() ?? 0.0,
                min: 0,
                max: widget.numberOfOptions.toDouble(),
                divisions: widget.numberOfOptions,
                onChanged: (double value) {
                  setState(() {
                    _selectedValue = value.toInt();
                  });
                  widget.onChanged?.call(_selectedValue.toString());
                },
                label: _selectedValue?.toString(),
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
