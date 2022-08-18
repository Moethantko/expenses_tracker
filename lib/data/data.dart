import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_tracker/helpers/firebase_helper.dart';

class Data extends ChangeNotifier {
  late User currentUser;

  int currentSelectedYear =
      int.parse(DateFormat('yyyy').format(DateTime.now()));

  void updateCurrentSelectedYear(newYear) {
    currentSelectedYear = newYear;
    notifyListeners();
  }

  String currentSelectedMonth = DateFormat('MMM').format(DateTime.now());

  FirebaseHelper firebaseHelper = FirebaseHelper();
  late Stream<QuerySnapshot<Map<String, dynamic>>> snaps =
      firebaseHelper.filterExpensesDataByYearMonth(
          currentSelectedYear, currentSelectedMonth, currentUser.email);

  void updateSnaps() {
    snaps = firebaseHelper.filterExpensesDataByYearMonth(
        currentSelectedYear, currentSelectedMonth, currentUser.email);
    notifyListeners();
  }

  String currentSelectedCategory = 'Food';
  void updateCurrentSelectedCategory(String newValue) {
    currentSelectedCategory = newValue;
    notifyListeners();
  }

  int latestAddedYear = 2022;

  List<int> allYearsData = [2019, 2020, 2021, 2022, 2023];
  updateAllYearsData(BuildContext context) async {
    allYearsData.sort();
    await firebaseHelper.retrieveYearsFromDB(context);
    notifyListeners();
  }

  List<String> allMonthsData = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  double totalSpending = 0;
  void updateTotalSpending(BuildContext context) async {
    await firebaseHelper.calculateTotalSpending(
        currentSelectedYear, currentSelectedMonth, context);
    notifyListeners();
  }
}
