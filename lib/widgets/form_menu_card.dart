import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../models/form_model.dart';
import '../screens/create_form.dart';
import '../screens/form_response_analysis_screen.dart';
import '../services/form_firebase_service.dart';

class MenuCardWidget {
  static Future<void> showMenuCard(BuildContext context, FormModel form) async {
    bool hasResponses = await FormFirebaseService().hasFormResponses(form.id);

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
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FormResponseAnalysisScreen(
                        formId: form.id,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.edit, color: hasResponses ? Colors.grey : Colors.black),
                title: Text('Düzenle', style: TextStyle(color: hasResponses ? Colors.grey : Colors.black)),
                onTap: hasResponses
                    ? null // Yanıt varsa düzenlemeyi devre dışı bırakıyoruz
                    : () {
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
                  bool confirmDelete = await _showDeleteConfirmationDialog(context);
                  if (confirmDelete) {
                    await FormFirebaseService().deleteFormWithResponsesAndNotifications(context, form);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child : Text('Formu sil')),
          content: Text('Bu formla ilgili tüm veriler silinecek. Bu formu ve form yanıtlarını silmek istediğinizden emin misiniz?'),
          contentTextStyle: TextStyle(color: Colors.black, fontSize: 17),
          actions: <Widget>[
            TextButton(
              child: Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Sil', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
