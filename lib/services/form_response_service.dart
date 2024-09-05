import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/form_model.dart';
import '../models/form_response_model.dart';

class FormResponseService {
  final String formId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FormResponseService({required this.formId});

  static Future<FormModel> fetchFormById(String formId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('forms')
          .doc(formId)
          .get();

      if (doc.exists) {
        return FormModel.fromJson(doc.data()!);
      } else {
        throw Exception('Form bulunamadı');
      }
    } catch (e) {
      throw Exception('Form yüklenirken hata oluştu: $e');
    }
  }

  Future<bool> isEmailAlreadyUsed(String email) async {
    final querySnapshot = await _firestore
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
          content: Center(child: Text('Bu e-posta adresi ile form zaten cevaplanmış.')),
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
        SnackBar(content: Center(child: Text('Lütfen tüm zorunlu alanları doldurun.'))),
      );
      return;
    }

    try {
      final docRef = _firestore.collection('form_responses').doc();
      final formResponse = FormResponseModel(
        formId: formId,
        email: email,
        name: firstName,
        surname: lastName,
        responses: responses,
        userId: FirebaseAuth.instance.currentUser!.uid,
        responseId: docRef.id,
      );

      await docRef.set(formResponse.toJson());

      final formOwner = FirebaseAuth.instance.currentUser!.uid;
      final notification = {
        'title': '$firstName $lastName formu yanıtladı',
        'body': '${form.title} formunu yanıtladı',
        'userId': formOwner,
        'formId': formId,
        'responseId': docRef.id,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('notifications')
          .add(notification);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text('Yanıt başarıyla kaydedildi!'))),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text('Yanıt kaydedilirken hata oluştu'))),
      );
    }
  }

  static Future<FormResponseModel?> getResponseById(String responseId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('form_responses')
          .doc(responseId)
          .get();

      if (doc.exists) {
        return FormResponseModel.fromJson(doc.data()!);
      } else {
        print('No document found for the given responseId');
        return null;
      }
    } catch (e) {
      print('Error fetching response: $e');
      return null;
    }
  }

  Future<List<FormResponseModel>> fetchFormResponses() async {
    final querySnapshot = await _firestore
        .collection('form_responses')
        .where('formId', isEqualTo: formId)
        .get();

    return querySnapshot.docs
        .map((doc) => FormResponseModel.fromJson(doc.data()))
        .toList();
  }
}
