class FormResponseModel {
  final String formId;
  final String email;
  final String name;
  final String surname;
  final Map<String, dynamic> responses;

  FormResponseModel({
    required this.formId,
    required this.email,
    required this.name,
    required this.surname,
    required this.responses,
  });

  // JSON'dan model oluşturma
  factory FormResponseModel.fromJson(Map<String, dynamic> json) {
    return FormResponseModel(
      formId: json['formId'],
      email: json['email'],
      name: json['name'],
      surname: json['surname'],
      responses: Map<String, dynamic>.from(json['responses']),
    );
  }

  // Modeli JSON formatına çevirme
  Map<String, dynamic> toJson() {
    return {
      'formId': formId,
      'email': email,
      'name': name,
      'surname': surname,
      'responses': responses,
    };
  }
}
