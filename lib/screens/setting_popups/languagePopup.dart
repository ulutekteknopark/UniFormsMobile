import 'package:flutter/material.dart';

void showLanguage(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero, // Padding'i sıfırlar
        content: Container(
          width: double.maxFinite, // Dialog genişliğini sınırlamaz
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //_listTile(text: 'sa', value: 1),
                ListTile(
                  title: Text('İngilizce'),
                  leading: Radio(
                    value: 2,
                    groupValue:
                        1, // Bu değeri kontrol etmek için bir state yönetimi kullanmalısınız
                    onChanged: (value) {
                      // Radio button seçildiğinde yapılacak işlemler
                    },
                  ),
                ),
                ListTile(
                  title: Text('Almanca'),
                  leading: Radio(
                    value: 3,
                    groupValue:
                        1, // Bu değeri kontrol etmek için bir state yönetimi kullanmalısınız
                    onChanged: (value) {
                      // Radio button seçildiğinde yapılacak işlemler
                    },
                  ),
                ),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Popup'ı kapatır
                    },
                    child: Text('Kaydet'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
