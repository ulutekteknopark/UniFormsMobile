import 'package:deneme2/managers/text_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void showProfile(BuildContext context) {
  final User? user = FirebaseAuth.instance.currentUser;
  final String? userEmail = user?.email ?? 'Email not available';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Center(
                child: CircleAvatar(
                  backgroundColor: Color(0xFF665399),
                  radius: 60,
                  child: Icon(
                    Icons.person,
                    size: 75,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  TextManager().email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(userEmail ?? 'Email not available'),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  TextManager().nameAndSurname,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              /*
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Text(
                  TextManager().password,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              */
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Kapat'),
          ),
        ],
      );
    },
  );
}
