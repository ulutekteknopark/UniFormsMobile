import 'package:deneme2/screens/home_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../models/form_model.dart';
import '../screens/create_form.dart';
import '../services/form_firebase_service.dart';

class MenuCardWidget {
  static void showMenuCard(BuildContext context, FormModel form) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Card(
          color: Color(0xFFF7F2FA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Color(0xFF79747E),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  form.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.mail_outline, color: Colors.black),
                title: Text('Form Yanıtları'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.black),
                title: Text('Düzenle'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateForm(
                        form: form,
                        isEditing: true,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: Colors.black),
                title: Text('Paylaş'),
                onTap: () async {
                  String link =
                      await FormFirebaseService().createDynamicLink(form.id);
                  Share.share('Bu formu yanıtlayabilirsiniz: $link');
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_forever, color: Colors.red),
                title: Text('Sil', style: TextStyle(color: Colors.red)),
                onTap: () async {
                  await FormFirebaseService().deleteForm(context, form);
                },
              ),
              // Menü kartına alt padding ekleniyor
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
