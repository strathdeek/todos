import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaysDate extends StatelessWidget {
  const TodaysDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'TODAY : ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(DateFormat.yMMMMd('en_US').format(DateTime.now()).toUpperCase(),
            style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
