import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme2/models/form_component.dart';

import '../models/base_form_model.dart';

/*class FormModel extends BaseFormModel {
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
}*/
class FormModel extends BaseFormModel {
  String subtitle;
  final String id;
  List<FormComponent> components = [];
  DateTime? validFrom;
  DateTime? validUntil;

  FormModel({
    required String title,
    required this.subtitle,
    required bool isStarred,
    required this.id,
    required this.components,
    this.validFrom,
    this.validUntil,
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
      validFrom: json['validFrom'] != null
          ? (json['validFrom'] as Timestamp).toDate()
          : null,
      validUntil: json['validUntil'] != null
          ? (json['validUntil'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'isStarred': isStarred,
      'components': components.map((component) => component.toJson()).toList(),
      'validFrom': validFrom != null ? Timestamp.fromDate(validFrom!) : null,
      'validUntil': validUntil != null ? Timestamp.fromDate(validUntil!) : null,
    };
  }
}

