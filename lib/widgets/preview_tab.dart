import 'package:deneme2/models/form_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/form_model.dart';
import '../screens/home_screen.dart';
import '../services/form_firebase_service.dart';

class PreviewTab extends StatelessWidget {
  final String formTitle;
  final List<FormComponent> components;
  final FormFirebaseService firebaseService;
  final FormModel? form;

  PreviewTab({
    required this.formTitle,
    required this.components,
    required this.firebaseService,
    required this.form,
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
                    if (components.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Forma en az bir bileşen ekleyiniz.')));
                    } else if (formTitle.isEmpty ||
                        formTitle == 'Form Başlığı') {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Form başlığı boş ya da varsayılan olarak bırakılamaz.')));
                    } else {
                      firebaseService.saveFormToFirestore(
                          context, form, formTitle, components);
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
              ],
            ),
          ),
          SizedBox(height: 20),
          ...components.map((component) {
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
        ],
      ),
    );
  }
}
