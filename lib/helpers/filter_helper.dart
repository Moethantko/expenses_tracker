import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/helpers/global_variables_helper.dart';
import 'package:personal_expenses_tracker/main.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_helper.dart';

class FilterHelper {

  FirebaseHelper firebaseHelper = FirebaseHelper();

  showFormForFiltering(BuildContext context) {

    firebaseHelper.retrieveYearsFromDB();
    firebaseHelper.retrieveMonthsFromDB();

    int _selectedYear = 2022;
    String _seletedMonth = 'Jan';

    Alert(
        context: context,
        title: "Filter by year or month",
        content: Column(
          children: <Widget>[
            Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.green,),
                SizedBox(
                  width: 230,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<int>(
                        value: _selectedYear,
                        style: const TextStyle(color: Colors.green),
                        onChanged: (int? newValue) {
                          _selectedYear = newValue!;
                        },
                        items: GlobalVariablesHelper.allYearsData
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.green,),
                SizedBox(
                  width: 230,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _seletedMonth,
                        style: const TextStyle(color: Colors.green),
                        onChanged: (String? newValue) {
                          _seletedMonth = newValue!;
                          },
                        items: GlobalVariablesHelper.allMonthsData
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => {
              //Navigator.of(context).pop(),
              GlobalVariablesHelper.yearForDataFilter = _selectedYear,
              GlobalVariablesHelper.monthForDataFilter = _seletedMonth,
              Provider.of<ExpensesData>(context, listen: false).updateSnaps(),
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