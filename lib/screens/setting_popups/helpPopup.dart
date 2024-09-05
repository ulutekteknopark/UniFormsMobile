import 'package:flutter/material.dart';

void showHelp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero, // Padding'i sıfırlar
        content: SizedBox(
          width: double.maxFinite, // Dialog genişliğini sınırlamaz
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Sıkça Sorulan Sorular'),
                  onTap: () {},
                ),
                /*
                ListTile(
                  title: Text('Canlı Destek'),
                  onTap: () {},
                ),
                 */
                ListTile(
                  title: Text('İletişim Formu'),
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                const Text(
                  'Mesajınız',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  maxLength: 500,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Mesajınızı buraya yazınız...',
                  ),
                  buildCounter: (BuildContext context,
                      {required int currentLength,
                      required bool isFocused,
                      required int? maxLength}) {
                    return Text(
                      '$currentLength/$maxLength karakter',
                      style: TextStyle(fontSize: 12),
                    );
                  },
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Popup'ı kapatır
                    },
                    child: Text('Gönder'),
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
