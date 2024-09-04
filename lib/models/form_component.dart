import 'package:flutter/cupertino.dart';
import 'check_box_component.dart';
import 'dropdown_menu_component.dart';
import 'radio_button_component.dart';
import 'rating_scale_component.dart';
import 'text_field_component.dart';
import 'matris_component.dart';

abstract class FormComponent {
  String get id;
  bool get isRequired;

  // buildComponent metoduna initialValue ve enabled parametrelerini ekleyin
  Widget buildComponent({
    Function(String)? onChanged,
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
