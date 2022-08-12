import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/helpers/firebase_helper.dart';

class Data extends ChangeNotifier {
  int currentSelectedYear = 2022;

  void updateCurrentSelectedYear(newYear) {
    currentSelectedYear = newYear;
    notifyListeners();
  }

  String currentSelectedMonth = 'Aug';

  FirebaseHelper firebaseHelper = FirebaseHelper();
  late Stream<QuerySnapshot<Map<String, dynamic>>> snaps = firebaseHelper
      .filterExpensesDataByYearMonth(currentSelectedYear, currentSelectedMonth);

  void updateSnaps() {
    snaps = firebaseHelper.filterExpensesDataByYearMonth(
        currentSelectedYear, currentSelectedMonth);
    notifyListeners();
  }

  String currentSelectedCategory = 'Food';
  void updateCurrentSelectedCategory(String newValue) {
    currentSelectedCategory = newValue;
    notifyListeners();
  }

  int latestAddedYear = 2022;

  List<int> allYearsData = [2019, 2020, 2021, 2022];
  updateAllYearsData(BuildContext context) async {
    //allYearsData.add(latestAddedYear);
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
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  int totalSpending = 0;
  void updateTotalSpending(BuildContext context) async {
    await firebaseHelper.calculateTotalSpending(
        currentSelectedYear, currentSelectedMonth, context);
    notifyListeners();
  }
}
