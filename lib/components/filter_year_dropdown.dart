import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/data/data.dart';
import 'package:personal_expenses_tracker/helpers/firebase_helper.dart';
import 'package:personal_expenses_tracker/helpers/global_variables_helper.dart';
import 'package:provider/provider.dart';

class FilterYearDropdown extends StatefulWidget {
  const FilterYearDropdown({Key? key}) : super(key: key);

  @override
  State<FilterYearDropdown> createState() => _FilterYearDropdownState();
}

class _FilterYearDropdownState extends State<FilterYearDropdown> {

  int _selectedYear = 2022;
  FirebaseHelper firebaseHelper = FirebaseHelper();

  @override
  Widget build(BuildContext context) {

    firebaseHelper.retrieveYearsFromDB();

    return Row(
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
                  setState(() {
                    _selectedYear = newValue!;
                    Provider.of<Data>(context, listen: false).updateCurrentSelectedYear(newValue);
                  });
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
    );
  }
}
