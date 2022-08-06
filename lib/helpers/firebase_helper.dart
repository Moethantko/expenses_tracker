import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:personal_expenses_tracker/helpers/global_variables_helper.dart';
import 'package:personal_expenses_tracker/models/expense.dart';

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
  
  /*Future<void> storeSpendingData(int year, String month, int spending) async {
    int totalSpending = 0;
    //print("Hello. It's herereerererer");

    await FirebaseFirestore.instance.collection('total_spendings')
        .where('year', isEqualTo: year)
        .where('month', isEqualTo: month)
        .snapshots().forEach((element) {
          final docs = element.docs;
          for (var doc in docs) {
            totalSpending += int.parse(doc.get('total_spending').toString());
            print("Hello. It's total...${totalSpending}");
          }
        }).then((value) => {
          print("async function above is completed....."),
          FirebaseFirestore.instance.collection('total_spendings').add({
            'year': year,
            'month': month,
            'total_spending': totalSpending + spending
          }),
        });
  }*/

  deleteSelectedExpenseData(String id) {
    FirebaseFirestore.instance.collection("expenses").doc(id).delete().then(
          (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }

  retrieveYearsFromDB() async {
    await FirebaseFirestore.instance.collection('expenses').snapshots().forEach((element) {
      final docs = element.docs;
      for (var doc in docs) {
        int year = doc.get('year');
        if (!GlobalVariablesHelper.allYearsData.contains(year)) {
          GlobalVariablesHelper.allYearsData.add(year);
        }
      }
    });
  }

  retrieveMonthsFromDB() async {
    await FirebaseFirestore.instance.collection('expenses').snapshots().forEach((element) {
      final docs = element.docs;
      for (var doc in docs) {
        final month = doc.get('month').toString();
        if (!GlobalVariablesHelper.allMonthsData.contains(month)) {
          GlobalVariablesHelper.allMonthsData.add(month);
        }
      }
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> filterExpensesDataByYearMonth(selectedYear, selectedMonth) {
    return FirebaseFirestore.instance.collection('expenses')
        .where("year", isEqualTo: selectedYear)
        .where("month", isEqualTo: selectedMonth).snapshots();
  }

  /*calculateTotalSpending(selectedYear, selectedMonth) {
    int totalSpending = 0;
    FirebaseFirestore.instance.collection('expenses')
        .where("year", isEqualTo: selectedYear)
        .where("month", isEqualTo: selectedMonth)
        .snapshots()
        .forEach((element) {
          final docs = element.docs;
          for (var doc in docs) {
            //totalSpending += int.parse(doc.get('price').toString());
          }
        }).then((value) => {
    print("it's hereeeeeee: ${totalSpending}"),
    });
  }*/
}