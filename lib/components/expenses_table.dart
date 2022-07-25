import 'package:flutter/material.dart';

class ExpensesTable extends StatelessWidget {
  const ExpensesTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: <TableRow>[
          TableRow(
            decoration: const BoxDecoration(
                color: Colors.white
            ),
            children: <Widget>[
              TableHeader(headerName: "Category"),
              TableHeader(headerName: "Price"),
              TableHeader(headerName: "Date"),
            ],
          ),
          TableRow(
              children: <Widget>[
                TableRowItem(itemName: "Food"),
                TableRowItem(itemName: "${String.fromCharCodes(Runes('\u0024'))}300"),
                TableRowItem(itemName: "July 24, 2022"),
              ]
          ),
          TableRow(
              children: <Widget>[
                TableRowItem(itemName: "Movie"),
                TableRowItem(itemName: "${String.fromCharCodes(Runes('\u0024'))}200"),
                TableRowItem(itemName: "July 20, 2022"),
              ]
          ),
          TableRow(
              children: <Widget>[
                TableRowItem(itemName: "Food"),
                TableRowItem(itemName: "${String.fromCharCodes(Runes('\u0024'))}300"),
                TableRowItem(itemName: "July 24, 2022"),
              ]
          ),
          TableRow(
              children: <Widget>[
                TableRowItem(itemName: "Trip"),
                TableRowItem(itemName:  "${String.fromCharCodes(Runes('\u0024'))}800"),
                TableRowItem(itemName: "July 13, 2022"),
              ]
          ),
          TableRow(
              children: <Widget>[
                TableRowItem(itemName: "Education"),
                TableRowItem(itemName: "${String.fromCharCodes(Runes('\u0024'))}150"),
                TableRowItem(itemName: "July 24, 2022"),
              ]
          ),
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {

  TableHeader({
    required this.headerName
  });

  final String headerName;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: 33,
      color: Colors.green,
      child: Text(headerName, style: const TextStyle(color: Colors.white),),
    );
  }
}

class TableRowItem extends StatelessWidget {

  const TableRowItem({Key? key,
    required this.itemName
  }) : super(key: key);

  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: 33,
      child: Text(itemName, style: const TextStyle(color: Colors.green),),
    );
  }
}