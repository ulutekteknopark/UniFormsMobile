import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
  final bool obscureText;
  final bool isPassword;

  BuildTextField({
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.labelText,
    this.obscureText = false,
    required this.isPassword,
  });

  @override
  BuildTextFieldState createState() => BuildTextFieldState();
}

class BuildTextFieldState extends State<BuildTextField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          filled: true,
          fillColor: const Color(0xFFE6E0E9),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: widget.isPassword ? _passwordVisible : widget.obscureText,
      ),
    );
  }
}
