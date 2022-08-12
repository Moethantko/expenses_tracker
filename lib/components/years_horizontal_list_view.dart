import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/components/pressable_widget.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';

class YearsHorizontalListView extends StatefulWidget {
  const YearsHorizontalListView({Key? key}) : super(key: key);
  @override
  State<YearsHorizontalListView> createState() =>
      _YearsHorizontalListViewState();
}

class _YearsHorizontalListViewState extends State<YearsHorizontalListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: buildYearContainersList(context),
        ),
      ),
    );
  }
}

List<Widget> buildYearContainersList(BuildContext context) {
  List<Widget> yearContainerList = [];

  for (int year in Provider.of<Data>(context, listen: true).allYearsData) {
    yearContainerList.add(PressableWidget(
      type: 'year',
      year: year,
    ));
  }
  return yearContainerList;
}
