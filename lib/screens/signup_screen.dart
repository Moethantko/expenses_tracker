import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/screens/home.dart';

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
  bool emailWarningHidden = false;

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
        emailWarningHidden = true;
      });
      return false;
    } else {
      setState(() {
        emailWarningHidden = false;
      });
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses Tracker',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              visible: emailWarningHidden,
              child: const Text('Email is not in correct format.'),
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
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);
                    //print('Testing purposes: ${userCredential.user}');
                    Navigator.pushReplacementNamed(context, HomeScreen.id);
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
