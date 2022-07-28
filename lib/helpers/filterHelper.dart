import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilterHelper {
  final List<String> _allYearsData = <String>[];
  final List<String> _allMonthsData = <String>[];

  showFormForFiltering(BuildContext context) {

    retrieveYearsFromDB();
    retrieveMonthsFromDB();

    for (var temp in _allMonthsData) {
      print(temp);
    }

    String _selectedYear = '2022';
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
                      child: DropdownButton<String>(
                        value: _selectedYear,
                        style: const TextStyle(color: Colors.green),
                        onChanged: (String? newValue) {
                          _selectedYear = newValue!;
                        },
                        items: _allYearsData
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
                        items: _allMonthsData
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
              Navigator.of(context).pop(),
            },
            child: const Text(
              "Filter",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ]).show();
  }

  retrieveYearsFromDB() async {
    await FirebaseFirestore.instance.collection('expenses').snapshots().forEach((element) {
      final docs = element.docs;
      for (var doc in docs) {
        final year = doc.get('year').toString();
        if (!_allYearsData.contains(year)) {
          _allYearsData.add(year);
        }
      }
    });
  }

  retrieveMonthsFromDB() async {
    await FirebaseFirestore.instance.collection('expenses').snapshots().forEach((element) {
      final docs = element.docs;
      for (var doc in docs) {
        final month = doc.get('month').toString();
        if (!_allMonthsData.contains(month)) {
          _allMonthsData.add(month);
        }
      }
    });
  }

}