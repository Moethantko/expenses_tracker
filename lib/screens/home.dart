import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/components/expenses_table.dart';
import 'package:personal_expenses_tracker/components/add_expense_form.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
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
                )
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(top: 15.0),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5)
              ),
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