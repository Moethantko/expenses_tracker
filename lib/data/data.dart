import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/helpers/firebase_helper.dart';
import 'package:personal_expenses_tracker/helpers/global_variables_helper.dart';

class Data extends ChangeNotifier {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  late Stream<QuerySnapshot<Map<String, dynamic>>> snaps =
  firebaseHelper.filterExpensesDataByYearMonth(GlobalVariablesHelper.yearForDataFilter, GlobalVariablesHelper.monthForDataFilter);

  void updateSnaps() {
    snaps = firebaseHelper.filterExpensesDataByYearMonth(GlobalVariablesHelper.yearForDataFilter, GlobalVariablesHelper.monthForDataFilter);
    notifyListeners();
  }

  String currentSelectedCategory = 'Food';
  void updateCurrentSelectedCategory (String newValue) {
    currentSelectedCategory = newValue;
    notifyListeners();
  }

  int currentSelectedYear = 2022;
  void updateCurrentSelectedYear (int newValue) {
    currentSelectedYear = newValue;
    notifyListeners();
  }

  /*List<int> allYearsData = <int>[];
  void populateAllYearsData () {
    //allYearsData = firebaseHelper.retrieveYearsFromDB();
    notifyListeners();
  }

  List<String> allMonthsData = <String>[];
  void populateAllMonthsData () {
    allMonthsData = firebaseHelper.retrieveMonthsFromDB();
    notifyListeners();
  }*/

}