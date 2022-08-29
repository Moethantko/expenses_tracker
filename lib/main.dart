import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/helpers/auth_helper.dart';
import 'package:personal_expenses_tracker/screens/delete_account_screen.dart';
import 'package:personal_expenses_tracker/screens/login_screen.dart';
import 'package:personal_expenses_tracker/screens/signup_screen.dart';
import 'package:provider/provider.dart';

import './screens/home.dart';
import 'data/data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Data()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  AuthHelper authHelper = AuthHelper();
  String initialScreen = LoginScreen.id;

  bool _isInternetConnected = false;
  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.wifi) {
      setState(() {
        _isInternetConnected = true;
      });
    } else if (result == ConnectivityResult.mobile) {
      setState(() {
        _isInternetConnected = true;
      });
    } else {
      setState(() {
        _isInternetConnected = false;
      });
    }
  }

  @override
  void initState() {
    checkIfTokenExists();
    _checkConnectivityState();
    super.initState();
  }

  void checkIfTokenExists() async {
    if (await authHelper.getToken() != null) {
      initialScreen = SignUpScreen.id;
    } else {
      initialScreen = LoginScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses Tracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong.");
          } else if (snapshot.hasData && _isInternetConnected) {
            return HomeScreen();
          } else if (!_isInternetConnected) {
            return const Text(
                'Please connect to internet and restart the app.');
          } else {
            return const Text("Something is returned");
          }
        },
      ),
      initialRoute: initialScreen,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        DeleteAccountScreen.id: (context) => const DeleteAccountScreen(),
      },
    );
  }
}
