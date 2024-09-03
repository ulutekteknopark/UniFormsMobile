import 'package:deneme2/screens/notifications_screen.dart';
import 'package:deneme2/screens/forms_screen.dart';
import 'package:deneme2/screens/templates_screen.dart';
import 'package:deneme2/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex = 0;

  List<Widget> widgetList = const [
    FormsScreen(),
    TemplateScreen(),
    NotificationsScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFF3EDF7),
          selectedIconTheme: const IconThemeData(
            size: 28,
            color: Colors.black,
          ),
          unselectedIconTheme: const IconThemeData(
            size: 28,
            color: Colors.grey,
          ),
          selectedItemColor: Colors.black,
          // Seçili yazı rengi
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: Scaffold(
        body: Center(
          child: widgetList[myIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          type: BottomNavigationBarType.fixed, // Simge büyümesini önler
          items: [
            BottomNavigationBarItem(
              //icon: Image.asset(
              //'assets/icons/ic_form.png',
              icon: Icon(Icons.assignment),
              label: 'Formlar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.language),
              label: 'Şablonlar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: 'Bildirimler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Ayarlar',
            ),
          ],
        ),
      ),
    );
  }
}
