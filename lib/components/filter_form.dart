import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/helpers/filter_helper.dart';

class FilterForm extends StatefulWidget {
  const FilterForm({Key? key}) : super(key: key);
  @override
  State<FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {

  FilterHelper filterHelper = FilterHelper();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        filterHelper.showFormForFiltering(context);
      },
      child: const Text(
        'Filter',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
