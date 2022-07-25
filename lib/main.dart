import 'package:flutter/material.dart';
import './screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
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
            print("You have an error!!");
            return const Text("Something went wrong.");
          } else if (snapshot.hasData){
            return HomeScreen(title: "Expenses Tracker");
          } else {
            return const Text("Something is returned");
          }
        },
      ),
    );
  }
}


