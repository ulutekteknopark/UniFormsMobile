import 'package:deneme2/models/radio_button_component.dart';
import 'package:deneme2/models/rating_scale_component.dart';
import 'package:deneme2/models/text_field_component.dart';
import 'package:flutter/cupertino.dart';

import 'check_box_component.dart';
import 'dropdown_menu_component.dart';
import 'matris_component.dart';

abstract class FormComponent {
  String get id;
  String get title;
  bool get isRequired;

  // Yeni type getter
  String get type;

  Widget buildComponent({
    Function(dynamic)? onChanged,
    String initialValue = '',
    bool enabled = true,
  });

  Map<String, dynamic> toJson();
  void updateFromJson(Map<String, dynamic> json);

  static FormComponent fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'text':
        return TextFieldComponent.fromJson(json);
      case 'checkbox':
        return CheckBoxComponent.fromJson(json);
      case 'radio':
        return RadioButtonComponent.fromJson(json);
      case 'dropdown':
        return DropdownComponent.fromJson(json);
      case 'rating_scale':
        return RatingScaleComponent.fromJson(json);
      case 'matris':
        return MatrisComponent.fromJson(json);
      default:
        throw Exception('Unknown form component type');
    }
  }
}
