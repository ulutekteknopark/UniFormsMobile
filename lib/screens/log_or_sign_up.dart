import 'package:deneme2/managers/text_manager.dart';
import 'package:deneme2/screens/log_in_screen.dart';
import 'package:deneme2/screens/sign_up.dart';
import 'package:flutter/material.dart';

class LogOrSignUp extends StatefulWidget {
  const LogOrSignUp({super.key});

  @override
  State<LogOrSignUp> createState() => _LogOrSignUpState();
}

class _LogOrSignUpState extends State<LogOrSignUp> {
  final double _edgeInsetsTop = 25;
  final double _edgeInsetsTop2x = 50;
  final double _edgeInsetsAll = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const UpImage(),
          Padding(
            // merhaba text
            padding: EdgeInsets.all(_edgeInsetsAll),
            child: Text(
              TextManager().hello,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          //Merhaba! Text
          Padding(
            padding: EdgeInsets.only(top: _edgeInsetsTop2x),
            child: Text(
              TextManager().welcome,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          // Giris Yap Butonu
          Padding(
            padding: EdgeInsets.only(top: _edgeInsetsTop),
            child: const LogInButton(
              horizontal: 120.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: _edgeInsetsTop2x),
            child: Text(
              TextManager().noAccount,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(TextManager().downBackground),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 120),
                child: SignUpButton(horizontal: 60),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key, required this.horizontal});

  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 12.0),
        backgroundColor: const Color(0XFF21005D),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignUp(),
          ),
        );
      },
      child: Text(
        TextManager().signUp,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}

class LogInButton extends StatelessWidget {
  const LogInButton({super.key, required this.horizontal});

  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 12.0),
        backgroundColor: const Color(0XFF21005D),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      },
      child: Text(
        TextManager().login,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}

class UpImage extends StatelessWidget {
  const UpImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      // up_image
      children: [
        Positioned(
          child: Image.asset(
            TextManager().upBackground,
          ),
        ),
        Positioned(
          top: 100,
          left: 145,
          child: Image.asset(
            TextManager().uniformsLogo,
          ),
        ),
        Positioned(
          top: 200,
          left: 100,
          child: Image.asset(
            TextManager().uniformsText,
          ),
        ),
      ],
    );
  }
}
