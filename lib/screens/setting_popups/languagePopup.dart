import 'package:flutter/material.dart';

void showLanguage(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LanguageDialog();
    },
  );
}

class LanguageDialog extends StatefulWidget {
  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  int _selectedLanguage = 2; // 2 turkce secili demek

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Türkçe'),
                leading: Radio(
                  value: 2,
                  groupValue: _selectedLanguage,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('İngilizce'),
                leading: Radio(
                  value: 3,
                  groupValue: _selectedLanguage,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),
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
  }
}
