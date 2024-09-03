import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> editTitleDialog(
    BuildContext context, String currentTitle, Function(String) onSave) {
  TextEditingController _titleController =
      TextEditingController(text: currentTitle);

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Başlığı Düzenle"),
        content: TextField(
          controller: _titleController,
          decoration: InputDecoration(
            hintText: "Yeni başlık girin",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              onSave(_titleController.text);
              Navigator.of(context).pop();
            },
            child: Text("Kaydet"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("İptal"),
          ),
        ],
      );
    },
  );
}
