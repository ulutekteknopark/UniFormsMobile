import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void createFormMenuCard({
  required BuildContext context,
  required VoidCallback onAddTextField,
  required VoidCallback onAddCheckboxes,
  required VoidCallback onAddRadioButtons,
  required VoidCallback onAddDropdown,
  required VoidCallback onAddRatingScale,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Card(
        margin: EdgeInsets.only(bottom: 24.0),
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
                'Bileşen Ekle',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text('Metin Alanı'),
              onTap: () {
                Navigator.pop(context);
                onAddTextField();
              },
            ),
            ListTile(
              title: Text('Onay Kutuları'),
              onTap: () {
                Navigator.pop(context);
                onAddCheckboxes();
              },
            ),
            ListTile(
              title: Text('Seçim Kutuları'),
              onTap: () {
                Navigator.pop(context);
                onAddRadioButtons();
              },
            ),
            ListTile(
              title: Text('Açılır Menü'),
              onTap: () {
                Navigator.pop(context);
                onAddDropdown();
              },
            ),
            ListTile(
              title: Text('Derecelendirme Ölçeği'),
              onTap: () {
                Navigator.pop(context);
                onAddRatingScale();
              },
            ),
          ],
        ),
      );
    },
  );
}
