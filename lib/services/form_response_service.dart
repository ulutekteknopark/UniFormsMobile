import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/form_model.dart';
import '../models/form_response_model.dart';

class FormResponseService {
  final String formId;

  FormResponseService({required this.formId});

  Future<FormModel> fetchForm() async {
    final doc =
        await FirebaseFirestore.instance.collection('forms').doc(formId).get();
    return FormModel.fromJson(doc.data()!);
  }

  Future<bool> isEmailAlreadyUsed(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('form_responses')
        .where('formId', isEqualTo: formId)
        .where('email', isEqualTo: email)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  bool isEmailValid(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@(gmail\.com|hotmail\.com|yahoo\.com|protonmail\.com|outlook\.com|icloud\.com|proton\.me)$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> submitForm({
    required String email,
    required String firstName,
    required String lastName,
    required Map<String, dynamic> responses,
    required GlobalKey<FormState> formKey,
    required Future<FormModel> formFuture,
    required BuildContext context,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (await isEmailAlreadyUsed(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
              child: Text('Bu e-posta adresi ile form zaten cevaplanmış.')),
        ),
      );
      return;
    }

    if (!isEmailValid(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text('Geçersiz e-posta adresi.'))),
      );
      return;
    }

    final form = await formFuture;
    bool allRequiredAnswered = true;
    for (var component in form.components) {
      if (component.isRequired && !responses.containsKey(component.id)) {
        allRequiredAnswered = false;
        break;
      }
    }

    if (!allRequiredAnswered) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Center(child: Text('Lütfen tüm zorunlu alanları doldurun.'))),
      );
      return;
    }

    try {
      final formResponse = FormResponseModel(
        formId: formId,
        email: email,
        name: firstName,
        surname: lastName,
        responses: responses,
      );
      await FirebaseFirestore.instance
          .collection('form_responses')
          .add(formResponse.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text('Yanıt başarıyla kaydedildi!'))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Center(child: Text('Yanıt kaydedilirken hata oluştu'))),
      );
    }
  }
}
