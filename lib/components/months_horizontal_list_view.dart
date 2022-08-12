import 'package:flutter/material.dart';
import 'package:personal_expenses_tracker/components/pressable_widget.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';

class MonthsHorizontalListView extends StatefulWidget {
  const MonthsHorizontalListView({Key? key}) : super(key: key);

  @override
  State<MonthsHorizontalListView> createState() =>
      _MonthsHorizontalListViewState();
}

class _MonthsHorizontalListViewState extends State<MonthsHorizontalListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: buildMonthContainersList(context),
        ),
      ),
    );
  }
}

List<Widget> buildMonthContainersList(BuildContext context) {
  List<Widget> monthContainersList = [];
  for (String month
      in Provider.of<Data>(context, listen: false).allMonthsData) {
    monthContainersList.add(
      PressableWidget(
        type: 'month',
        month: month,
      ),
    );
  }
  return monthContainersList;
}
