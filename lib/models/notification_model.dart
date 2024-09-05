class NotificationModel {
  final String title;
  final String body;
  final String responseId;

  NotificationModel({
    required this.title,
    required this.body,
    required this.responseId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      responseId: json['responseId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'responseId': responseId,
    };
  }
}
