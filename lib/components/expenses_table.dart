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

/*List<DataRow> buildDataRows(List<QueryDocumentSnapshot> expenses) {
  List<DataRow> dataRows = [];

  for (var expense in expenses) {
    List<DataCell> dataCells = [];

    String id = expense.id;
    String category = expense.get('category');
    String price =
        "${String.fromCharCodes(Runes('\u0024'))}${expense.get('price').toString()}";
    String date = expense.get('date').toString();

    dataCells.add(DataCell(Text(category)));
    dataCells.add(DataCell(Text(price)));
    dataCells.add(DataCell(Text(date)));

    dataRows.add(DataRow(cells: dataCells));
  }
  return dataRows;
}

class TableRowItem extends StatelessWidget {
  const TableRowItem({
    Key? key,
    required this.id,
    required this.itemName,
    required this.color,
    required this.textColor,
    this.icon,
  }) : super(key: key);

  final String id;
  final String itemName;
  final Color color;
  final Color textColor;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    FirebaseHelper firebaseHelper = FirebaseHelper();

    if (icon == null) {
      return Container(
        alignment: Alignment.center,
        width: 32,
        height: 33,
        color: color,
        child:
            Text(itemName, style: TextStyle(color: textColor, fontSize: 13.5)),
      );
    } else {
      return GestureDetector(
        onTap: () {
          firebaseHelper.deleteSelectedExpenseData(id);
          Provider.of<Data>(context, listen: false)
              .updateTotalSpending(context);
          Provider.of<Data>(context, listen: false).updateAllYearsData(context);
        },
        child: Container(
          alignment: Alignment.center,
          width: 5,
          height: 33,
          color: color,
          child: Icon(
            icon?.icon,
            color: Colors.redAccent,
            size: 20,
          ),
        ),
      );
    }
  }
}

List<TableRow> buildHeaderAndRowItemWidgets(
    List<QueryDocumentSnapshot> expenses) {
  List<TableRow> rowWidgets = [];

  List<TableRowItem> rowTableHeaderWidgets = [];
  rowTableHeaderWidgets.add(const TableRowItem(
      id: "1",
      itemName: 'Category',
      color: Colors.green,
      textColor: Colors.white));
  rowTableHeaderWidgets.add(const TableRowItem(
      id: "2",
      itemName: 'Price',
      color: Colors.green,
      textColor: Colors.white));
  rowTableHeaderWidgets.add(const TableRowItem(
      id: "3", itemName: 'Date', color: Colors.green, textColor: Colors.white));
  rowTableHeaderWidgets.add(const TableRowItem(
      id: "4", itemName: '', color: Colors.green, textColor: Colors.white));

  rowWidgets.add(TableRow(children: rowTableHeaderWidgets));

  for (var expense in expenses) {
    List<TableRowItem> rowItemWidgets = [];

    String id = expense.id;
    String category = expense.get('category');
    String price =
        "${String.fromCharCodes(Runes('\u0024'))}${expense.get('price').toString()}";
    String date = expense.get('date').toString();

    rowItemWidgets.add(TableRowItem(
      id: id,
      itemName: category,
      color: Colors.white,
      textColor: Colors.green,
    ));
    rowItemWidgets.add(TableRowItem(
      id: id,
      itemName: price,
      color: Colors.white,
      textColor: Colors.green,
    ));
    rowItemWidgets.add(TableRowItem(
      id: id,
      itemName: date,
      color: Colors.white,
      textColor: Colors.green,
    ));
    rowItemWidgets.add(TableRowItem(
      id: id,
      itemName: '',
      color: Colors.white,
      textColor: Colors.green,
      icon: const Icon(Icons.delete_forever),
    ));

    rowWidgets.add(TableRow(children: rowItemWidgets));
  }

  return rowWidgets;
}*/
