import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/components/filter_month_dropdown.dart';
import 'package:personal_expenses_tracker/components/filter_year_dropdown.dart';
import 'package:personal_expenses_tracker/helpers/global_variables_helper.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/data.dart';
import 'firebase_helper.dart';

class FilterHelper {

  showFormForFiltering(BuildContext context) {

    Alert(
        context: context,
        title: "Filter by year or month",
        content: Column(
          children: const <Widget>[
            FilterYearDropdown(),
            SizedBox(
              height: 8,
            ),
            FilterMonthDropdown(),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => {
              //Navigator.of(context).pop(),
              GlobalVariablesHelper.yearForDataFilter = Provider.of<Data>(context, listen: false).currentSelectedYear,
              GlobalVariablesHelper.monthForDataFilter = Provider.of<Data>(context, listen: false).currentSelectedMonth,
              Provider.of<Data>(context, listen: false).updateSnaps(),
              Navigator.pop(context),
            },
            child: const Text(
              "Filter",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ]).show();
  }

  /*Future<int> retrieveTotalSpending() async {
    int total = 0;
    await FirebaseFirestore.instance.collection('expenses').snapshots().forEach((element) {
      final docs = element.docs;
      for (var doc in docs) {
        int price = doc.get('price');
        total += price;
      }
    });

    print('Total Spending = ${total}');
    return total;
  }*/

}