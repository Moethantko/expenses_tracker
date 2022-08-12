import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<Data>(context).snaps,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<QueryDocumentSnapshot> expenses = snapshot.data!.docs;
          //List<TableRow> rowWidgets = buildHeaderAndRowItemWidgets(expenses);

          return ListView.builder(
              shrinkWrap: true,
              itemCount: expenses.length,
              itemBuilder: (BuildContext context, int index) {
                final expense = expenses[index];
                String id = expense.id;
                String category = expense.get('category');
                String price =
                    "${String.fromCharCodes(Runes('\u0024'))}${expense.get('price').toString()}";
                String date = expense.get('date').toString();

                return TableRow(
                  id: id,
                  category: category,
                  price: price,
                  date: date,
                );
              });
        },
      ),
    );
  }
}

class TableColumn extends StatelessWidget {
  const TableColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.green,
          padding: const EdgeInsets.all(5),
          child: const Text(
            'Category',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          color: Colors.green,
          padding: const EdgeInsets.all(5),
          child: const Text(
            'Food',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          color: Colors.green,
          padding: const EdgeInsets.all(5),
          child: const Text(
            'Date',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class TableRow extends StatelessWidget {
  const TableRow(
      {Key? key,
      required this.id,
      required this.category,
      required this.price,
      required this.date,
      this.icon})
      : super(key: key);

  final String id;
  final String category;
  final String price;
  final String date;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              category,
              style: const TextStyle(color: Colors.green),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              price,
              style: const TextStyle(color: Colors.green),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              date,
              style: const TextStyle(color: Colors.green),
            ),
          ),
        ),
      ],
    );
  }
}

List<TableRow> buildTableRows(List<QueryDocumentSnapshot> expenses) {
  List<TableRow> tableRows = [];

  for (var expense in expenses) {
    String id = expense.id;
    String category = expense.get('category');
    String price =
        "${String.fromCharCodes(Runes('\u0024'))}${expense.get('price').toString()}";
    String date = expense.get('date').toString();

    tableRows.add(TableRow(
      id: id,
      category: category,
      price: price,
      date: date,
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
