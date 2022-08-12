import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/helpers/firebase_helper.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';

class TableRowData extends StatelessWidget {
  const TableRowData({
    Key? key,
    required this.id,
    required this.category,
    required this.price,
    required this.date,
    this.icon,
    required this.containerColor,
    required this.textColor,
    required this.fontSize,
    required this.containerPadding,
  }) : super(key: key);

  final String id;
  final String category;
  final String price;
  final String date;
  final Icon? icon;
  final Color containerColor;
  final Color textColor;
  final double fontSize;
  final double containerPadding;

  @override
  Widget build(BuildContext context) {
    FirebaseHelper firebaseHelper = FirebaseHelper();

    if (icon != null) {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              firebaseHelper.deleteSelectedExpenseData(id);
              Provider.of<Data>(context, listen: false)
                  .updateTotalSpending(context);
              Provider.of<Data>(context, listen: false)
                  .updateAllYearsData(context);
            },
            child: Container(
              width: 45,
              alignment: Alignment.center,
              color: containerColor,
              padding: EdgeInsets.all(containerPadding),
              child: const Icon(
                Icons.delete_forever_rounded,
                size: 20,
                color: Colors.red,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: containerColor,
              padding: EdgeInsets.all(containerPadding),
              child: Text(
                category,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: containerColor,
              padding: EdgeInsets.all(containerPadding),
              child: Text(
                price,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: containerColor,
              padding: EdgeInsets.all(containerPadding),
              child: Text(
                date,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            width: 45,
            alignment: Alignment.center,
            color: containerColor,
            padding: EdgeInsets.all(containerPadding),
            child: const Icon(
              Icons.delete,
              size: 20,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: containerColor,
              padding: EdgeInsets.all(containerPadding),
              child: Text(
                category,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: containerColor,
              padding: EdgeInsets.all(containerPadding),
              child: Text(
                price,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              color: containerColor,
              padding: EdgeInsets.all(containerPadding),
              child: Text(
                date,
                style: TextStyle(color: textColor, fontSize: fontSize),
              ),
            ),
          ),
        ],
      );
    }
  }
}
