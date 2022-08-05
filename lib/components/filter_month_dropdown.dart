import 'package:flutter/material.dart';
import '../data/data.dart';
import '../helpers/global_variables_helper.dart';
import 'package:provider/provider.dart';

class FilterMonthDropdown extends StatefulWidget {
  const FilterMonthDropdown({Key? key}) : super(key: key);

  @override
  State<FilterMonthDropdown> createState() => _FilterMonthDropdownState();
}

class _FilterMonthDropdownState extends State<FilterMonthDropdown> {

  String _seletedMonth = GlobalVariablesHelper.allMonthsData.elementAt(0);

  @override
  Widget build(BuildContext context) {

    //firebaseHelper.retrieveMonthsFromDB();

    return Row(
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
                  setState(() {
                    _seletedMonth = newValue!;
                    Provider.of<Data>(context, listen: false).updateCurrentSelectedMonth(newValue);
                  });
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
    );
  }
}
