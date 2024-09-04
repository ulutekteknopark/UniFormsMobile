class FormResponseModel {
  final String formId;
  final String email;
  final String name;
  final String surname;
  final Map<String, dynamic> responses;
  final String userId;
  final String responseId;

  FormResponseModel({
    required this.formId,
    required this.email,
    required this.name,
    required this.surname,
    required this.responses,
    required this.userId,
    required this.responseId,
  });

  factory FormResponseModel.fromJson(Map<String, dynamic> json) {
    return FormResponseModel(
      formId: json['formId'],
      email: json['email'],
      name: json['name'],
      surname: json['surname'],
      responses: json['responses'],
      userId: json['userId'],
      responseId: json['responseId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'formId': formId,
      'email': email,
      'name': name,
      'surname': surname,
      'responses': responses,
      'userId': userId,
      'responseId': responseId,
    };
  }
}
