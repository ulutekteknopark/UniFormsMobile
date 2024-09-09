import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deneme2/managers/text_manager.dart';
import 'package:deneme2/screens/log_in_screen.dart';
import 'package:deneme2/services/firebase_auth_service.dart'; // FirebaseAuthService sınıfını ekleyin
import '../widgets/build_text_field.dart';
import 'log_or_sign_up.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  bool _obscurePassword = false;
  bool _isTermsAccepted = false;
  bool _isKVKKAccepted = false;

  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0XFFFEF7FF),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          icon: const Icon(Icons.chevron_left_outlined),
        ),
        title: Text(
          TextManager().signUp,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            BuildTextField(
              controller: _emailController,
              hintText: TextManager().email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              obscureText: false,
              isPassword: false,
              labelText: TextManager().email,
            ),
            Row(
              children: [
                Expanded(
                  child: BuildTextField(
                    controller: _firstNameController,
                    hintText: TextManager().firstName,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    obscureText: false,
                    isPassword: false,
                    labelText: TextManager().firstName,
                  ),
                ),
                Expanded(
                  child: BuildTextField(
                    controller: _lastNameController,
                    hintText: TextManager().lastName,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    obscureText: false,
                    isPassword: false,
                    labelText: TextManager().lastName,
                  ),
                ),
              ],
            ),
            BuildTextField(
              controller: _passwordController,
              hintText: TextManager().password,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              labelText: TextManager().password,
              isPassword: true,
              obscureText: !_obscurePassword,
            ),
            BuildTextField(
              controller: _confirmPasswordController,
              hintText: TextManager().confirmPassword,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              labelText: TextManager().confirmPassword,
              isPassword: true,
              obscureText: !_obscurePassword,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _isTermsAccepted,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isTermsAccepted = newValue ?? false;
                    });
                  },
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Hizmet koşullarını okudum, onaylıyorum.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _isKVKKAccepted,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isKVKKAccepted = newValue ?? false;
                    });
                  },
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'KVKK metnini okudum, onaylıyorum.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 60, vertical: 15.0),
                backgroundColor: const Color(0XFF21005D),
              ),
              child: Text(
                TextManager().signUp,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Stack(
              children: [
                Image.asset(
                  TextManager().signUpBackground,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 312,
                ),
                Positioned(
                  top: 20,
                  left: 190,
                  child: Text(TextManager().or),
                ),
                Positioned(
                  top: 100,
                  left: 120,
                  child: Text(TextManager().hasAccount),
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 3.8,
                  child: LogInButton(horizontal: 120),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;

    if (email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text('E-posta, şifre, isim ve soyisim alanları zorunludur.'),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text('Girdiğiniz şifreler uyuşmuyor.'),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_isTermsAccepted || !_isKVKKAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text('KVKK ve Hizmet Koşullarımızı kabul etmelisiniz.'),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await _firebaseAuthService.signUpWithEmailAndPassword(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      context: context,
    );
  }
}
