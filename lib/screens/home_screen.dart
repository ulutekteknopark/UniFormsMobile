import 'package:deneme2/managers/text_manager.dart';
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
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const FormsScreen(),
    const TemplateScreen(),
    const NotificationsScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFF3EDF7),
          selectedIconTheme: IconThemeData(
            size: 28,
          ),
          unselectedIconTheme: IconThemeData(
            size: 28,
            color: Colors.grey,
          ),
          selectedItemColor: Color.fromARGB(255, 125, 17, 192),
          // Seçili yazı rengi
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: const Color.fromARGB(255, 125, 17, 192),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.assignment),
              label: TextManager().forms,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.language),
              label: TextManager().template,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              label: TextManager().notifications,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: TextManager().settings,
            ),
          ],
        ),
      ),
    );
  }
}
