import 'package:deneme2/managers/text_manager.dart';
import 'package:deneme2/screens/log_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screens/home_screen.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        if (user.emailVerified) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          showSnackBar(context, 'Lütfen emailinizi onaylayın.');
        }
      }
    } on FirebaseAuthException catch (e) {
      handleAuthError(e, context);
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await user.sendEmailVerification();
        showVerificationDialog(context);
      }
    } on FirebaseAuthException catch (e) {
      handleAuthError(e, context);
    }
  }

  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        if (user.emailVerified) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          showSnackBar(context, 'Lütfen emailinizi onaylayın.');
        }
      }
    } on FirebaseAuthException catch (e) {
      handleAuthError(e, context);
    }
  }

  Future<void> sendPasswordResetEmail({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, 'Şifre sıfırlama e-postası gönderildi.');
    } on FirebaseAuthException catch (e) {
      handleAuthError(e, context);
    }
  }

  Future<void> checkUserSession({required BuildContext context}) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        if (user.emailVerified) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          showSnackBar(context, 'Lütfen emailinizi onaylayın.');
        }
      } else {
        showSnackBar(context, 'Kullanıcı girişi yapılmamış.');
      }
    } catch (e) {
      showSnackBar(context, 'Bir hata oluştu: ${e.toString()}');
    }
  }

  void handleAuthError(FirebaseAuthException e, BuildContext context) {
    String errorMessage;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = TextManager().notRegistered;
        break;
      case 'invalid-credential':
        errorMessage = TextManager().wrongPassword;
        break;
      case 'invalid-email':
        errorMessage = TextManager().notExist;
        break;
      case 'channel-error':
        errorMessage = TextManager().enterSomething;
        break;
      case 'email-already-in-use':
        errorMessage = 'E-posta adresi zaten kullanımda.';
        break;
      default:
        errorMessage = TextManager().error;
        break;
    }
    showSnackBar(context, errorMessage);
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showVerificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Email Doğrulama')),
          content: Text(
            'E-posta adresinize bir doğrulama e-postası gönderildi. Hesabınızı doğrulamak için lütfen e-postanızı kontrol edin.',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showForgotPasswordDialog(BuildContext context) {
    final TextEditingController _forgotPasswordController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Şifremi Unuttum'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Lütfen kayıtlı e-posta adresinizi girin, size bir şifre sıfırlama bağlantısı gönderelim.',
            ),
            SizedBox(height: 10),
            TextField(
              controller: _forgotPasswordController,
              decoration: InputDecoration(
                labelText: 'E-posta',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Center(
                      child: Text('Şifre sıfırlama e-postası gönderildi.')),
                  backgroundColor: Colors.green,
                ),
              );
              sendPasswordResetEmail(
                email: _forgotPasswordController.text,
                context: context,
              );
            },
            child: Text('Gönder'),
          ),
        ],
      ),
    );
  }

  Future<void> logOut({required BuildContext context}) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }
}
