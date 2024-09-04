import 'package:flutter/material.dart';

void showNotifications(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      bool isSwitched = true;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            content: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchListTile(
                      title: Text('Bildirimleri Aç/Kapat'),
                      value: isSwitched,
                      onChanged: (bool value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
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
    },
  );
}
