import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/helpers/firebase_helper.dart';
import 'package:personal_expenses_tracker/helpers/global_variables_helper.dart';
import './screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpensesData(),
      child: MaterialApp(
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
            } else if (snapshot.hasData){
              return HomeScreen(title: "Expenses Tracker");
            } else {
              return const Text("Something is returned");
            }
          },
        ),
      ),
    );
  }
}

class ExpensesData extends ChangeNotifier {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  late Stream<QuerySnapshot<Map<String, dynamic>>> snaps =
      firebaseHelper.filterExpensesDataByYearMonth(GlobalVariablesHelper.yearForDataFilter, GlobalVariablesHelper.monthForDataFilter);

  void updateSnaps() {
    snaps = firebaseHelper.filterExpensesDataByYearMonth(GlobalVariablesHelper.yearForDataFilter, GlobalVariablesHelper.monthForDataFilter);
    notifyListeners();
  }
}


