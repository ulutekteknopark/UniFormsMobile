import 'package:deneme2/models/form_component.dart';

import '../models/base_form_model.dart';

class FormModel extends BaseFormModel {
  String subtitle;
  final String id;
  List<FormComponent> components = [];

  FormModel({
    required String title,
    required this.subtitle,
    required bool isStarred,
    required this.id,
    required this.components,
  }) : super(title: title, isStarred: isStarred, createdAt: DateTime.now());

  factory FormModel.fromJson(Map<String, dynamic> json) {
    return FormModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'] ?? '',
      isStarred: json['isStarred'] ?? false,
      components: json['components'] != null
          ? (json['components'] as List)
              .map((component) => FormComponent.fromJson(component))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'isStarred': isStarred,
      'components': components.map((component) => component.toJson()).toList(),
    };
  }
}
