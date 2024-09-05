import '../models/base_form_model.dart';

class TemplateFormModel extends BaseFormModel {
  TemplateFormModel({
    required String title,
    required bool isStarred,
  }) : super(title: title, isStarred: isStarred, createdAt: DateTime.now());
}
