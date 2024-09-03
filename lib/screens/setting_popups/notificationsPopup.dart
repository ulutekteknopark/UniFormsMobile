import 'package:flutter/material.dart';

void showNotifications(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  title: Text('widget.text'),
                  value: true,
                  onChanged: (bool value) {},
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
