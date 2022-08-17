import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    _checkConnectivityState();
    super.initState();
  }

  /*late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  getInternetConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        //print('Is device connected: ${isDeviceConnected}');

        if (isDeviceConnected == false && isAlertSet == false) {
          print('device is not connected......');
          showConnectionAlert();
          setState(() {
            isAlertSet = true;
          });
        }
      });

  @override
  void initState() {
    getInternetConnectivity();
    super.initState();
  }

  showConnectionAlert() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('OK'),
            )
          ],
        ),
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }*/

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
      initialRoute: LoginScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
      },
    );
  }
}
