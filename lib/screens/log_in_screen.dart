import 'package:deneme2/managers/text_manager.dart';
import 'package:deneme2/services/firebase_auth_service.dart';
import 'package:deneme2/widgets/build_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'log_or_sign_up.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Future.delayed(Duration.zero, () {
      _firebaseAuthService.checkUserSession(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UpImage(),
            Text(
              TextManager().hello,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            BuildTextField(
              controller: _emailController,
              hintText: TextManager().exampleEmail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              labelText: TextManager().email,
              isPassword: false,
            ),
            SizedBox(height: 10),
            BuildTextField(
              controller: _passwordController,
              hintText: TextManager().password,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              labelText: TextManager().password,
              isPassword: true,
              obscureText: _obscurePassword,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _firebaseAuthService.showForgotPasswordDialog(context);
                },
                child: Text(
                  'Şifremi Unuttum',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15.0),
                backgroundColor: const Color(0xFF21005D),
              ),
              onPressed: () {
                _firebaseAuthService.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);
              },
              child: Text(
                TextManager().login,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            SizedBox(height: 30),
            Text(TextManager().or),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset(TextManager().googleLogo,
                      width: 40, height: 40),
                  onPressed: () {
                    _firebaseAuthService.signInWithGoogle(context: context);
                  },
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Image.asset(TextManager().appleLogo,
                      width: 40, height: 40),
                  iconSize: 30,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Center(
                              child: Text(
                                  'Yakında Apple ile giriş yapabileceksiniz.'))),
                    );
                  },
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Image.asset(TextManager().facebookLogo,
                      width: 40, height: 40),
                  iconSize: 30,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Center(
                              child: Text(
                                  'Yakında Facebook ile giriş yapabileceksiniz.'))),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(TextManager().downBackground),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      TextManager().noAccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 120),
                  child: SignUpButton(horizontal: 60),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
