import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/data/data.dart';
import 'package:personal_expenses_tracker/models/expense.dart';
import 'package:provider/provider.dart';

class FirebaseHelper {
  storeExpenseData(Expense expense) {
    FirebaseFirestore.instance.collection('expenses').add({
      'category': expense.category,
      'price': expense.price,
      'date': expense.date,
      'year': expense.year,
      'month': expense.month
    });
  }

  deleteSelectedExpenseData(String id) {
    FirebaseFirestore.instance.collection("expenses").doc(id).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  retrieveYearsFromDB(BuildContext context) async {
    final result =
        await FirebaseFirestore.instance.collection('expenses').get();
    for (var doc in result.docs) {
      if (!Provider.of<Data>(context, listen: false)
          .allYearsData
          .contains(doc.get('year'))) {
        Provider.of<Data>(context, listen: false)
            .allYearsData
            .add(doc.get('year'));
        Provider.of<Data>(context, listen: false).allYearsData.sort();
      }
    }
  }

  /*retrieveMonthsFromDB(context) async {
    await FirebaseFirestore.instance
        .collection('expenses')
        .snapshots()
        .forEach((snap) {
      final docs = snap.docs;
      for (var doc in docs) {
        final month = doc.get('month').toString();
        if (!GlobalVariablesHelper.allMonthsData.contains(month)) {
          GlobalVariablesHelper.allMonthsData.add(month);
        }
      }
    });
  }*/

  Stream<QuerySnapshot<Map<String, dynamic>>> filterExpensesDataByYearMonth(
      selectedYear, selectedMonth) {
    return FirebaseFirestore.instance
        .collection('expenses')
        .where("year", isEqualTo: selectedYear)
        .where("month", isEqualTo: selectedMonth)
        .snapshots();
  }

  calculateTotalSpending(selectedYear, selectedMonth, context) async {
    int totalSpending = 0;

    final result = await FirebaseFirestore.instance
        .collection('expenses')
        .where("year", isEqualTo: selectedYear)
        .where("month", isEqualTo: selectedMonth)
        .get();
    for (final doc in result.docs) {
      totalSpending += int.parse(doc.get('price').toString());
    }
    Provider.of<Data>(context, listen: false).totalSpending = totalSpending;
    //print(Provider.of<Data>(context, listen: false).totalSpending);
  }
}
