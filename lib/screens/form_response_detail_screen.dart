import 'package:flutter/material.dart';
import '../models/check_box_component.dart';
import '../models/form_model.dart';
import '../models/form_response_model.dart';
import '../services/form_response_service.dart';
import '../widgets/form_response_text_fields.dart';

class FormResponseDetailScreen extends StatelessWidget {
  final String responseId;

  const FormResponseDetailScreen({required this.responseId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEF7FF),
        title: Text('Yanıt Detayları'),
        centerTitle: true,
      ),
      body: FutureBuilder<FormResponseModel?>(
        future: FormResponseService.getResponseById(responseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Yanıt yüklenirken hata oluştu'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Yanıt bulunamadı'));
          }

          final response = snapshot.data!;
          return FutureBuilder<FormModel>(
            future: FormResponseService.fetchFormById(response.formId),
            builder: (context, formSnapshot) {
              if (formSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (formSnapshot.hasError) {
                return Center(child: Text('Form yüklenirken hata oluştu'));
              } else if (!formSnapshot.hasData) {
                return Center(child: Text('Form bulunamadı'));
              }

              final form = formSnapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FormResponseTextField(
                        controller: TextEditingController(text: response.email),
                        labelText: 'E-posta Adresi',
                        enabled: false,
                        validatorMessage: '',
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: FormResponseTextField(
                              controller: TextEditingController(text: response.name),
                              labelText: 'İsim',
                              enabled: false,
                              validatorMessage: '',
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: FormResponseTextField(
                              controller: TextEditingController(text: response.surname),
                              labelText: 'Soyisim',
                              enabled: false,
                              validatorMessage: '',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Column(
                        children: form.components.map((component) {
                          final responseValue = response.responses[component.id];

                          // Veriyi String türüne dönüştür
                          String displayValue = '';
                          if (responseValue is List) {
                            displayValue = responseValue.join(','); // Listeyi String'e çevir
                          } else if (responseValue != null) {
                            displayValue = responseValue.toString();
                          }

                          if (component is CheckBoxComponent) {
                            return component.buildComponent(
                              initialValue: displayValue,
                              onChanged: (value) {},
                              enabled: false,
                            );
                          } else {
                            return component.buildComponent(
                              initialValue: displayValue,
                              onChanged: (value) {},
                              enabled: false,
                            );
                          }
                        }).toList(),
                      ),
                      SizedBox(height: 80.0),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
