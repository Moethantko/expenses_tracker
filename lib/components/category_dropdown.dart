import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({Key? key}) : super(key: key);

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String _selectedCategory = 'Food';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.category,
          color: Colors.green,
        ),
        SizedBox(
          width: 230,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                value: _selectedCategory,
                style: const TextStyle(color: Colors.green),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                    Provider.of<Data>(context, listen: false)
                        .updateCurrentSelectedCategory(newValue);
                  });
                },
                items: <String>[
                  'Food',
                  'Entertainment',
                  'Health',
                  'Education',
                  'Fashion',
                  'Subscriptions',
                  'Household',
                  'Gift',
                  'Other'
                ].map<DropdownMenuItem<String>>((String value) {
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
