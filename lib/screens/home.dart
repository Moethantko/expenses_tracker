import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/components/add_expense_form.dart';
import 'package:personal_expenses_tracker/components/months_horizontal_list_view.dart';
import 'package:personal_expenses_tracker/components/years_horizontal_list_view.dart';
import 'package:personal_expenses_tracker/helpers/firebase_helper.dart';
import 'package:provider/provider.dart';

import '../components/expenses_table.dart';
import '../data/data.dart';

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
    int currentSelectedYear =
        Provider.of<Data>(context, listen: true).currentSelectedYear;
    String currentSelectedMonth =
        Provider.of<Data>(context, listen: true).currentSelectedMonth;

    firebaseHelper.retrieveYearsFromDB(context);
    firebaseHelper.calculateTotalSpending(
        currentSelectedYear, currentSelectedMonth, context);

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
          ],
        ),
      ),
      body: Column(
        children: [
          const YearsHorizontalListView(),
          const SizedBox(height: 0.5),
          const MonthsHorizontalListView(),
          Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total Spending for ',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      currentSelectedYear.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      currentSelectedMonth,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )),
          Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: Text(
                "${String.fromCharCodes(Runes('\u0024'))}${Provider.of<Data>(context, listen: true).totalSpending}",
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
