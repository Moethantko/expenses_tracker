import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../helpers/global_variables_helper.dart';

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
      height: 35,
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
  //List<int> allYearsData = Provider.of<FilterDataProvider>(context, listen: false).allYearsData;
  List<Widget> yearContainerList = [];

  for (int year in Provider.of<Data>(context, listen: false).allYearsData) {
    yearContainerList.add(
      GestureDetector(
        onTap: () => {
          GlobalVariablesHelper.yearForDataFilter = year,
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
            year.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
  return yearContainerList;
}
