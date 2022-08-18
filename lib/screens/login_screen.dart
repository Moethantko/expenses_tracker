import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_expenses_tracker/screens/home.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool userNotFoundWarningDisplayed = false;
  bool passwordIncorrectWarningDisplayed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            'Expenses Tracker',
            style: TextStyle(color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, SignUpScreen.id);
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 16),
            ),
          )
        ]),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.moneyBills),
              color: Colors.green,
              iconSize: 70,
              onPressed: () {
                print("Pressed");
              },
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: const InputDecoration(hintText: "Email"),
            ),
            Visibility(
              visible: userNotFoundWarningDisplayed,
              child: const Text('User not found for this email.'),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: const InputDecoration(hintText: "Password"),
            ),
            Visibility(
              visible: passwordIncorrectWarningDisplayed,
              child: const Text('Password is incorrect.'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushReplacementNamed(context, HomeScreen.id);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    setState(() {
                      userNotFoundWarningDisplayed = true;
                    });
                  } else {
                    setState(() {
                      userNotFoundWarningDisplayed = false;
                    });
                  }

                  if (e.code == 'wrong-password') {
                    setState(() {
                      passwordIncorrectWarningDisplayed = true;
                    });
                  } else {
                    setState(() {
                      passwordIncorrectWarningDisplayed = false;
                    });
                  }
                }
              },
              child: const Text('Log In'),
            )
          ],
        ),
      ),
    );
  }
}
