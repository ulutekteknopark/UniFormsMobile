import 'package:deneme2/managers/text_manager.dart';
import 'package:flutter/material.dart';

void showPrivacy(BuildContext context) {
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
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      TextManager().terms, // Metin içeriği
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Popup'ı kapatır
                  },
                  child: const Text('Kabul Ediyorum'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
