import 'package:deneme2/screens/log_in_screen.dart';
import 'package:deneme2/services/firebase_auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        appBarTheme: AppBarTheme(color: Colors.purple.shade50),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Ayarlar'), centerTitle: true),
        body: Center(
            child: ElevatedButton(
                onPressed: () {
                  FirebaseAuthService().logOut(context: context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Çıkış Yap'))),
      ),
    );
  }
}
