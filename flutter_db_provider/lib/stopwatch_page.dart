import 'package:flutter/material.dart';
import 'package:flutter_db_provider/timer_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//ignore: must_be_immutable
class StopwatchDisplay extends StatelessWidget {
  String time = "00:00:00";
  NumberFormat formatter = NumberFormat("00");

  StopwatchDisplay({super.key});

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    int hour = (timeInSecond / 3600).floor();
    return "${formatter.format(hour)}:${formatter.format(min)}:${formatter.format(sec)}";
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<TimerModel>();
    var seconds = model.seconds;

    // Format seconds
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              '${formattedTime(timeInSecond: seconds)}',
              style: const TextStyle(
                fontSize: 60.0, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: !model.running && !model.dirty,
              child: ElevatedButton(
                onPressed: () {
                  model.start();
                },
                child: const Text('Start'),
              ),
            ),
            Visibility(
              visible: model.running,
              child: ElevatedButton(
                onPressed: () {
                  model.pause();
                },
                child: const Text('Pause'),
              ),
            ),
            Visibility(
              visible: !model.running && model.dirty,
              child: ElevatedButton(
                onPressed: () {
                  model.resume();
                },
                child: const Text('Resume'),
              ),
            ),
            const SizedBox(width: 10),
            Visibility(
              visible:!model.running && model.dirty,
              child: ElevatedButton(
                onPressed: () {
                  model.finish();
                },
                child: const Text('Finish'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
