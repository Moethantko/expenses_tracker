import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';

class PressableWidget extends StatefulWidget {
  const PressableWidget({
    Key? key,
    required this.type,
    this.year,
    this.month,
  }) : super(key: key);

  final String type;
  final int? year;
  final String? month;

  @override
  State<PressableWidget> createState() => _PressableWidgetState();
}

class _PressableWidgetState extends State<PressableWidget> {
  Color _containerColor = Colors.green;
  Color _textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'year') {
      return GestureDetector(
        onTap: () => {
          Provider.of<Data>(context, listen: false).currentSelectedYear =
              widget.year!,
          Provider.of<Data>(context, listen: false).updateSnaps(),
          Provider.of<Data>(context, listen: false)
              .updateTotalSpending(context),
          setState(() {
            _containerColor = Colors.greenAccent;
            _textColor = Colors.green;
            Timer(const Duration(milliseconds: 500), () {
              setState(() {
                _containerColor = Colors.green;
                _textColor = Colors.white;
              });
            });
          }),
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _containerColor,
            border: const Border(
              right: BorderSide(width: 0.1, color: Colors.white),
            ),
          ),
          width: 100,
          child: Text(
            widget.year!.toString(),
            style: TextStyle(color: _textColor),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => {
          Provider.of<Data>(context, listen: false).currentSelectedMonth =
              widget.month!,
          Provider.of<Data>(context, listen: false).updateSnaps(),
          Provider.of<Data>(context, listen: false)
              .updateTotalSpending(context),
          setState(() {
            _containerColor = Colors.greenAccent;
            _textColor = Colors.green;
            Timer(const Duration(milliseconds: 500), () {
              setState(() {
                _containerColor = Colors.green;
                _textColor = Colors.white;
              });
            });
          }),
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _containerColor,
            border: const Border(
              right: BorderSide(width: 0.1, color: Colors.white),
            ),
          ),
          width: 100,
          child: Text(
            widget.month!,
            style: TextStyle(color: _textColor),
          ),
        ),
      );
    }
  }
}
