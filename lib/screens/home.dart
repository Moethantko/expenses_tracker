import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/components/add_expense_form.dart';
import 'package:personal_expenses_tracker/components/months_horizontal_list_view.dart';
import 'package:personal_expenses_tracker/components/years_horizontal_list_view.dart';
import 'package:personal_expenses_tracker/helpers/auth_helper.dart';
import 'package:personal_expenses_tracker/helpers/firebase_helper.dart';
import 'package:personal_expenses_tracker/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../components/expenses_table.dart';
import '../components/table_row_data.dart';
import '../data/data.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  AuthHelper authHelper = AuthHelper();

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      Provider.of<Data>(context, listen: false).currentUser =
          FirebaseAuth.instance.currentUser!;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentSelectedYear =
        Provider.of<Data>(context, listen: true).currentSelectedYear;
    String currentSelectedMonth =
        Provider.of<Data>(context, listen: true).currentSelectedMonth;

    firebaseHelper.retrieveYearsFromDB(context);

    firebaseHelper.calculateTotalSpending(
        currentSelectedYear, currentSelectedMonth, context);

    Provider.of<Data>(context, listen: false).snaps =
        firebaseHelper.filterExpensesDataByYearMonth(
            currentSelectedYear,
            currentSelectedMonth,
            Provider.of<Data>(context, listen: false).currentUser.email);

    return Scaffold(
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text(
            'Expenses Tracker',
            style: TextStyle(color: Colors.white),
          ),
          GestureDetector(
            onTap: () {
              authHelper.signOut();
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            },
            child: const Text(
              'Log Out',
              style: TextStyle(fontSize: 18),
            ),
          )
        ]),
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
            ),
          ),
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
          const SizedBox(
            height: 20,
          ),
          const TableRowData(
            id: 'id',
            category: 'Category',
            price: 'Price',
            date: 'Date',
            containerColor: Colors.green,
            textColor: Colors.white,
            fontSize: 17,
            containerPadding: 8,
          ),
          const ExpensesTable(),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButton: const AddExpenseForm(),
    );
  }
}
