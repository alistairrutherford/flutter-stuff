import 'package:flutter/material.dart';
import 'package:flutter_db_provider/timer_model.dart';
import 'package:provider/provider.dart';

import 'journey_point_model.dart';

//ignore: must_be_immutable
class StopwatchDisplay extends StatelessWidget {
  String time = "00:00:00";

  StopwatchDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    var model = context.watch<TimerModel>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              '$time',
              style: TextStyle(
                fontSize: 90.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
