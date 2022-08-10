import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/components/add_expense_form.dart';
import 'package:personal_expenses_tracker/components/filter_form.dart';
import 'package:personal_expenses_tracker/components/months_horizontal_list_view.dart';
import 'package:personal_expenses_tracker/components/years_horizontal_list_view.dart';
import 'package:personal_expenses_tracker/helpers/firebase_helper.dart';

import '../components/expenses_table.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  FirebaseHelper firebaseHelper = FirebaseHelper();

  @override
  Widget build(BuildContext context) {
    firebaseHelper.retrieveYearsFromDB(context);
    firebaseHelper.retrieveMonthsFromDB();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 125,
            ),
            const FilterForm(),
          ],
        ),
      ),
      body: Column(
        children: [
          const YearsHorizontalListView(),
          const SizedBox(
            height: 0.5,
          ),
          const MonthsHorizontalListView(),
          Center(
            child: Container(
                margin: const EdgeInsets.only(top: 20.0),
                alignment: Alignment.center,
                child: const Text(
                  "Total Spending",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                )),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: Text(
                "${String.fromCharCodes(Runes('\u0024'))}3000.0",
                style: const TextStyle(
                  fontSize: 27,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const ExpensesTable(),
        ],
      ),
      floatingActionButton: const AddExpenseForm(),
    );
  }
}
