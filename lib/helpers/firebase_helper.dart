import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_expenses_tracker/data/data.dart';
import 'package:personal_expenses_tracker/helpers/global_variables_helper.dart';
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

}