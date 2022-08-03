import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_expenses_tracker/main.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';

class ExpensesTable extends StatefulWidget {
  const ExpensesTable({Key? key}) : super(key: key);

  @override
  State<ExpensesTable> createState() => _ExpensesTable();
}

class _ExpensesTable extends State<ExpensesTable> {

  @override
  Widget build(BuildContext context) {
    return Container (
      margin: const EdgeInsets.only(top: 40),
      child: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<Data>(context).snaps,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator()
            );
          }
          final expenses = snapshot.data!.docs;

          List<TableRow> rowWidgets = [];
          List<TableRowItem> rowTableHeaderWidgets = [];
          rowTableHeaderWidgets.add(const TableRowItem(itemName: 'Category', color: Colors.green, textColor: Colors.white));
          rowTableHeaderWidgets.add(const TableRowItem(itemName: 'Price', color: Colors.green, textColor: Colors.white));
          rowTableHeaderWidgets.add(const TableRowItem(itemName: 'Date', color: Colors.green, textColor: Colors.white));

          rowWidgets.add(TableRow(children: rowTableHeaderWidgets));

          for (var expense in expenses) {
            List<TableRowItem> rowItemWidgets = [];

            final category = expense.get('category');
            final price = "${String.fromCharCodes(Runes('\u0024'))}${expense.get('price').toString()}";
            final date = expense.get('date').toString();

            rowItemWidgets.add(TableRowItem(itemName: category, color: Colors.white, textColor: Colors.green,));
            rowItemWidgets.add(TableRowItem(itemName: price, color: Colors.white, textColor: Colors.green,));
            rowItemWidgets.add(TableRowItem(itemName: date, color: Colors.white, textColor: Colors.green,));

            rowWidgets.add(TableRow(children: rowItemWidgets));
          }

          return Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: rowWidgets,
          );
        },
      ),
    );
  }
}

class TableRowItem extends StatelessWidget {
  const TableRowItem({Key? key,
    required this.itemName,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  final String itemName;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: 33,
      color: color,
      child: Text(itemName, style: TextStyle(color: textColor),),
    );
  }
}