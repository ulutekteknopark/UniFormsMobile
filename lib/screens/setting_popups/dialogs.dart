import 'package:deneme2/managers/text_manager.dart';
import 'package:flutter/material.dart';

void showProfile(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Center(
                child: CircleAvatar(
                  backgroundColor: Color(0xFF665399),
                  radius: 60,
                  child: Icon(
                    Icons.person,
                    size: 75,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  TextManager().email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Text(TextManager().exampleEmail),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  TextManager().nameAndSurname,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  TextManager().password,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Kapat'),
          ),
        ],
      );
    },
  );
}

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

void showTermsAndCond(BuildContext context) {
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
                      TextManager()
                          .terms, // Buraya metin içeriğinizi yerleştirin
                      style: TextStyle(fontSize: 16),
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
