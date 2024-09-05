import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/form_component.dart';
import '../models/form_model.dart';
import '../screens/home_screen.dart';

class FormFirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveFormToFirestore(BuildContext context, FormModel? form,
      String formTitle, List<FormComponent> components) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen önce giriş yapın.')),
      );
      return;
    }

    final formData = {
      'userId': user.uid,
      'title': formTitle,
      'components': components.map((component) => component.toJson()).toList(),
    };

    try {
      if (form == null) {
        final formId = Uuid().v4();
        await firestore.collection('forms').doc(formId).set({
          'id': formId,
          ...formData,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form başarıyla kaydedildi!')),
        );
      } else {
        await firestore.collection('forms').doc(form.id).update(formData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form başarıyla güncellendi!')),
        );
      }
    } catch (e) {
      print('Error saving form to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form kaydedilirken hata oluştu!')),
      );
    }
  }

  Future<List<FormModel>> fetchUserForms() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('Lütfen önce giriş yapın.');
    }

    try {
      final snapshot = await firestore
          .collection('forms')
          .where('userId', isEqualTo: user.uid)
          .get();

      return snapshot.docs.map((doc) {
        return FormModel.fromJson(doc.data());
      }).toList();
    } catch (e) {
      print('Error fetching user forms: $e');
      throw Exception('Kullanıcı formları alınırken hata oluştu.');
    }
  }

  Future<void> deleteForm(BuildContext context, FormModel form) async {
    try {
      await firestore.collection('forms').doc(form.id).delete();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form başarıyla silindi!')),
      );
    } catch (e) {
      print('Error deleting form: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form silinirken hata oluştu!')),
      );
      throw Exception('Form silinirken hata oluştu.');
    }
  }

  Future<String> createDynamicLink(String formId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://uniforms.page.link',
      link:
          Uri.parse('https://uniforms.page.link/form_response?formId=$formId'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.deneme2',
        minimumVersion: 1,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.example.deneme2',
        minimumVersion: '1.0.1',
      ),
    );

    final ShortDynamicLink dynamicUrl =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return dynamicUrl.shortUrl.toString();
  }
}
