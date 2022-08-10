import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../helpers/global_variables_helper.dart';

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
      GestureDetector(
        onTap: () => {
          GlobalVariablesHelper.monthForDataFilter = month,
          Provider.of<Data>(context, listen: false).updateSnaps(),
          Provider.of<Data>(context, listen: false)
              .updateTotalSpending(context),
        },
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.green,
            border: Border(
              right: BorderSide(width: 0.1, color: Colors.white),
            ),
          ),
          width: 100,
          child: Text(
            month,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
  return monthContainersList;
}
