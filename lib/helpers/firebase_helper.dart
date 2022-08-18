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
      'month': expense.month,
      'user': expense.username,
    });
  }

  deleteSelectedExpenseData(String id) {
    FirebaseFirestore.instance.collection("expenses").doc(id).delete().then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  retrieveYearsFromDB(BuildContext context) async {
    final result = await FirebaseFirestore.instance
        .collection('expenses')
        .where('user',
            isEqualTo:
                Provider.of<Data>(context, listen: false).currentUser.email)
        .get();
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

  Stream<QuerySnapshot<Map<String, dynamic>>> filterExpensesDataByYearMonth(
      selectedYear, selectedMonth, currentUser) {
    //print('Testing purposes in filtering :: $selectedMonth}');
    return FirebaseFirestore.instance
        .collection('expenses')
        .where("year", isEqualTo: selectedYear)
        .where("month", isEqualTo: selectedMonth)
        .where("user", isEqualTo: currentUser)
        .snapshots();
  }

  calculateTotalSpending(selectedYear, selectedMonth, context) async {
    double totalSpending = 0;
    final result = await FirebaseFirestore.instance
        .collection('expenses')
        .where("year", isEqualTo: selectedYear)
        .where("month", isEqualTo: selectedMonth)
        .where("user",
            isEqualTo:
                Provider.of<Data>(context, listen: false).currentUser.email)
        .get();
    for (final doc in result.docs) {
      totalSpending += double.parse(doc.get('price').toString());
    }
    Provider.of<Data>(context, listen: false).totalSpending = totalSpending;
  }
}
