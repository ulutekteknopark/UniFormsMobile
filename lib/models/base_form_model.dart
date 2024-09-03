abstract class BaseFormModel {
  String title;
  bool isStarred;
  DateTime createdAt = DateTime.now();

  BaseFormModel({
    required this.title,
    required this.isStarred,
    required this.createdAt,
  });
}
