import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deneme2/managers/text_manager.dart';
import 'package:deneme2/screens/log_or_sign_up.dart';
import 'package:deneme2/screens/form_response_screen.dart'; // Import the FormResponseScreen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart'; // Import Firebase Dynamic Links
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _handleDynamicLinks();
  }

  void _handleDynamicLinks() async {
    // Uygulama açıldığında dinamik bağlantı kontrolü
    FirebaseDynamicLinks.instance.onLink
        .listen((PendingDynamicLinkData? dynamicLinkData) {
      _navigateToFormResponseScreen(dynamicLinkData?.link);
    }).onError((error) {
      print('Link Error: ${error.toString()}');
    });

    // Uygulama kapalıyken dinamik bağlantı kontrolü
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _navigateToFormResponseScreen(data?.link);
  }

  void _navigateToFormResponseScreen(Uri? deepLink) {
    if (deepLink != null) {
      final formId = deepLink.queryParameters['formId'];
      if (formId != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FormResponseScreen(formId: formId),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  Widget content() {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Image.asset(
            TextManager().splashGif,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(TextManager().uniformsLogo),
                  SizedBox(width: 16),
                  Image.asset(TextManager().uniformsText),
                ],
              ),
              SizedBox(height: 60),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: _opentheApp,
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 16),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF21005D),
                  ),
                  child: Text(
                    TextManager().login,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _opentheApp() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LogOrSignUp()));
  }
}
