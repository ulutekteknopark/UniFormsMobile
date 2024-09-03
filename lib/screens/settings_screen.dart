import 'package:deneme2/managers/text_manager.dart';

import 'package:deneme2/screens/log_in_screen.dart';
import 'package:deneme2/screens/setting_popups/helpPopup.dart';
import 'package:deneme2/screens/setting_popups/languagePopup.dart';
import 'package:deneme2/screens/setting_popups/notificationsPopup.dart';
import 'package:deneme2/screens/setting_popups/privacyPopup.dart';
import 'package:deneme2/screens/setting_popups/profilePopup.dart';
import 'package:deneme2/screens/setting_popups/termsAndCondPopup.dart';
import 'package:deneme2/services/firebase_auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
      backgroundColor: Colors.white,
    );
  }

  Widget _body() {
    double height = 5;
    double height10x = 50;

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _settings(
          icon: Icons.person,
          subtitle: TextManager().profileSub,
          title: TextManager().profile,
          onTap: () {
            showProfile(context);
          },
        ),
        SizedBox(height: height),
        _settings(
          icon: Icons.person,
          subtitle: TextManager().notificationsSub,
          title: TextManager().notifications,
          onTap: () {
            showNotifications(context);
          },
        ),
        SizedBox(height: height),
        _settings(
          icon: Icons.person,
          subtitle: TextManager().languageSub,
          title: TextManager().language,
          onTap: () {
            showLanguage(context);
          },
        ),
        SizedBox(height: height),
        _settings(
          icon: Icons.person,
          subtitle: TextManager().helpSub,
          title: TextManager().help,
          onTap: () {
            showHelp(context);
          },
        ),
        SizedBox(height: height),
        _settings(
          icon: Icons.person,
          subtitle: TextManager().termsSub,
          title: TextManager().termsAndConditions,
          onTap: () {
            showTermsAndCond(context);
          },
        ),
        SizedBox(height: height),
        _settings(
          icon: Icons.person,
          subtitle: TextManager().privacySub,
          title: TextManager().privacyPolicy,
          onTap: () {
            showPrivacy(context);
          },
        ),
        SizedBox(height: height10x),
        _LogoutButton(
            //auth: _auth,
            ),
      ],
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0XFFFEF7FF),
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: Text(
      TextManager().settings,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    ),
  );
}

class _settings extends StatelessWidget {
  const _settings({
    super.key,
    required this.icon,
    required this.subtitle,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF665399),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 100,
        right: 100,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          backgroundColor: const Color(0xFF21005D),
        ),
        onPressed: () {
          FirebaseAuthService().logOut(context: context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Text(
          TextManager().logout,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
