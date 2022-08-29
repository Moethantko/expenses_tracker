import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_expenses_tracker/helpers/auth_helper.dart';
import 'package:personal_expenses_tracker/screens/home.dart';
import 'package:personal_expenses_tracker/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '';
  String password = '';
  String passwordConfirm = '';
  bool passwordCharWarningDisplayed = false;
  bool passwordNotMatchWarningDisplayed = false;
  bool emailWarningDisplayed = false;
  bool weakPasswordWarningHidden = false;
  bool emailAlreadyUsedWarningHidden = false;

  AuthHelper authHelper = AuthHelper();

  bool isEmailCorrectlyFormatted(String email) {
    if (email == null || email.isEmpty) {
      return false;
    }
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  bool isRequirementsSatisfied() {
    if (password.length < 6) {
      setState(() {
        passwordCharWarningDisplayed = true;
      });
      return false;
    } else {
      setState(() {
        passwordCharWarningDisplayed = false;
      });
    }

    if (password != passwordConfirm) {
      setState(() {
        passwordNotMatchWarningDisplayed = true;
      });
      return false;
    } else {
      setState(() {
        passwordNotMatchWarningDisplayed = false;
      });
    }

    if (!isEmailCorrectlyFormatted(email)) {
      setState(() {
        emailWarningDisplayed = true;
      });
      return false;
    } else {
      setState(() {
        emailWarningDisplayed = false;
      });
    }

    return true;
  }

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
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
            child: const Text(
              'Log In',
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
              visible: emailWarningDisplayed,
              child: const Text('Email is not in correct format.'),
            ),
            Visibility(
              visible: emailAlreadyUsedWarningHidden,
              child: const Text('Email is already taken.'),
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
              visible: passwordCharWarningDisplayed,
              child: const Text('Password must be at least 6 characters.'),
            ),
            Visibility(
              visible: passwordNotMatchWarningDisplayed,
              child: const Text('Password does not match.'),
            ),
            Visibility(
              visible: weakPasswordWarningHidden,
              child: const Text('Password is weak.'),
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                setState(() {
                  passwordConfirm = value;
                });
              },
              decoration: const InputDecoration(hintText: "Confirm Password"),
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
                if (isRequirementsSatisfied()) {
                  try {
                    UserCredential userCredential =
                        await authHelper.signUp(email, password);
                    Navigator.pushReplacementNamed(context, HomeScreen.id,
                        arguments: userCredential);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      setState(() {
                        weakPasswordWarningHidden = true;
                      });
                    } else {
                      setState(() {
                        weakPasswordWarningHidden = false;
                      });
                    }

                    if (e.code == 'email-already-in-use') {
                      setState(() {
                        emailAlreadyUsedWarningHidden = true;
                      });
                    } else {
                      setState(() {
                        emailAlreadyUsedWarningHidden = false;
                      });
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: const Text('Sign Up'),
            )
          ],
        ),
      ),
    );
  }
}
