import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_tracker/components/category_dropdown.dart';
import 'package:personal_expenses_tracker/data/data.dart';
import 'package:personal_expenses_tracker/helpers/date_helper.dart';
import 'package:personal_expenses_tracker/helpers/firebase_helper.dart';
import 'package:personal_expenses_tracker/models/expense.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddExpenseForm extends StatefulWidget {
  const AddExpenseForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddExpenseForm createState() => _AddExpenseForm();
}

class _AddExpenseForm extends State<AddExpenseForm> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _dateFieldController = TextEditingController();
  DateHelper dateHelper = DateHelper();

  _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      _selectedDate = pickedDate;
      _dateFieldController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dateFieldController.text.length,
            affinity: TextAffinity.upstream));
      Provider.of<Data>(context, listen: false).latestAddedYear =
          dateHelper.retrieveYear(_dateFieldController.text);
    }
  }

  _showAddExpenseForm(context) {
    double price = 0;
    DateHelper dateHelper = DateHelper();
    FirebaseHelper firebaseHelper = FirebaseHelper();

    Alert(
        context: context,
        title: "Add Expense",
        content: Column(
          children: <Widget>[
            const CategoryDropdown(),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                price = double.parse(value);
              },
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.attach_money,
                  color: Colors.green,
                ),
                labelText: 'Price',
              ),
            ),
            TextField(
              onTap: () => _selectDate(context),
              controller: _dateFieldController,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.today,
                  color: Colors.green,
                ),
                labelText: 'Date',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => {
              if (price < 0)
                {
                  price = 0,
                }
              else
                {
                  price = double.parse(price.toStringAsFixed(3)),
                },
              firebaseHelper.storeExpenseData(
                Expense(
                    category: Provider.of<Data>(context, listen: false)
                        .currentSelectedCategory,
                    price: price,
                    date: _dateFieldController.text,
                    year: dateHelper.retrieveYear(_dateFieldController.text),
                    month: dateHelper.retrieveMonth(_dateFieldController.text),
                    username: Provider.of<Data>(context, listen: false)
                        .currentUser
                        .email!),
              ),
              Provider.of<Data>(context, listen: false)
                  .updateAllYearsData(context),
              Provider.of<Data>(context, listen: false)
                  .updateTotalSpending(context),
              Navigator.pop(context),
            },
            child: const Text(
              "Add Expense",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        _showAddExpenseForm(context);
      },
      label: const Text('Add'),
      icon: const Icon(Icons.add),
      backgroundColor: Colors.green,
    );
  }
}
