import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import 'table_row_data.dart';

class ExpensesTable extends StatefulWidget {
  const ExpensesTable({Key? key}) : super(key: key);

  @override
  State<ExpensesTable> createState() => _ExpensesTable();
}

class _ExpensesTable extends State<ExpensesTable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<Data>(context).snaps,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<QueryDocumentSnapshot> expenses = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: buildTableRows(expenses),
            ),
          );
        },
      ),
    );
  }
}

List<TableRowData> buildTableRows(List<QueryDocumentSnapshot> expenses) {
  List<TableRowData> tableRows = [];

  for (var expense in expenses) {
    String id = expense.id;
    String category = expense.get('category');
    String price =
        "${String.fromCharCodes(Runes('\u0024'))}${expense.get('price').toString()}";
    String date = expense.get('date').toString();

    tableRows.add(TableRowData(
      id: id,
      category: category,
      price: price,
      date: date,
      containerColor: Colors.white,
      textColor: Colors.green,
      fontSize: 13,
      containerPadding: 7,
      icon: const Icon(Icons.delete_forever),
    ));
  }

  return tableRows;
}
