import 'package:deneme2/models/form_component.dart';
import 'package:flutter/material.dart';

import '../models/form_model.dart';
import '../screens/home_screen.dart';
import '../services/form_firebase_service.dart';

class PreviewTab extends StatelessWidget {
  final String formTitle;
  final List<FormComponent> components;
  final FormFirebaseService firebaseService;
  final FormModel? form;
  final DateTime? validFrom;
  final DateTime? validUntil;

  PreviewTab({
    required this.formTitle,
    required this.components,
    required this.firebaseService,
    required this.form,
    this.validFrom,
    this.validUntil,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    void showSnackBar(String message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(message),
                          ),
                        ),
                      );
                    }

                    if (components.isEmpty) {
                      showSnackBar('Forma en az bir bileşen ekleyiniz.');
                    } else if (formTitle.isEmpty ||
                        formTitle == 'Form Başlığı') {
                      showSnackBar(
                          'Form başlığı boş ya da varsayılan olarak bırakılamaz.');
                    } else if (validFrom == null || validUntil == null) {
                      showSnackBar(
                          'Form geçerlilik tarihleri boş bırakılamaz.');
                    } else if (validFrom!.isAfter(validUntil!)) {
                      showSnackBar(
                          'Başlangıç tarihi bitiş tarihinden büyük olamaz.');
                    } else {
                      firebaseService.saveFormToFirestore(context, form,
                          formTitle, components, validFrom, validUntil);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.save, color: Colors.white),
                  label: Text(
                    'Formu Kaydet',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF65558F),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  formTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (validFrom != null) ...[
                  SizedBox(height: 8),
                  Text(
                      'Geçerlilik Başlangıç Tarihi: ${validFrom.toString().split(' ')[0]}'),
                ],
                if (validUntil != null) ...[
                  SizedBox(height: 8),
                  Text(
                      'Geçerlilik Bitiş Tarihi:          ${validUntil.toString().split(' ')[0]}'),
                ],
              ],
            ),
          ),
          SizedBox(height: 20),
          components.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description,
                        size: 80,
                        color: Colors.black54,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Formunuzda herhangi bir bileşen yok.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                      Text(
                        'Formu kaydetmek için Düzenle ekranından en az bir bileşen ekleyiniz.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: components.map((component) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          component.buildComponent(),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
