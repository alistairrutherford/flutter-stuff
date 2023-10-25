import 'package:flutter/material.dart';
import 'package:flutter_db_provider/journey_model.dart';
import 'package:flutter_db_provider/timer_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'dao/journey.dart';

//ignore: must_be_immutable
class JourneyRecordView extends StatelessWidget {
  String time = "00:00:00";
  NumberFormat formatter = NumberFormat("00");
  Journey? _journey;

  JourneyRecordView({super.key});

  formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    int hour = (timeInSecond / 3600).floor();
    return "${formatter.format(hour)}:${formatter.format(min)}:${formatter.format(sec)}";
  }

  void start(TimerModel timerModel, JourneyModel journeyModel) async {
    _journey = await journeyModel.addJourney();
    timerModel.start();
  }

  void pause(TimerModel timerModel, JourneyModel journeyModel) {
    timerModel.pause();
  }

  void resume(TimerModel timerModel, JourneyModel journeyModel) {
    timerModel.resume();
  }

  void finish(TimerModel timerModel, JourneyModel journeyModel) async {
    timerModel.finish();
    if (_journey != null) {
      _journey!.endTime = DateTime.now();
      await journeyModel.updateJourney(_journey!);

      // Reset local copy of journey.
      _journey = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var timerModel = context.watch<TimerModel>();
    var journeyModel = context.watch<JourneyModel>();

    var seconds = timerModel.seconds;

    // Format seconds
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          height: timerModel.running ? 300.0 : 0.0,
          color: timerModel.running ? Colors.red : Colors.blue,
          alignment:
          timerModel.running ? Alignment.center : AlignmentDirectional.topCenter,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          child: const FlutterLogo(size: 75),
        ),
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
              visible: !timerModel.running && !timerModel.dirty,
              child: ElevatedButton(
                onPressed: () {
                  start(timerModel, journeyModel);
                },
                child: const Text('Start'),
              ),
            ),
            Visibility(
              visible: timerModel.running,
              child: ElevatedButton(
                onPressed: () {
                  pause(timerModel, journeyModel);
                },
                child: const Text('Pause'),
              ),
            ),
            Visibility(
              visible: !timerModel.running && timerModel.dirty,
              child: ElevatedButton(
                onPressed: () {
                  resume(timerModel, journeyModel);
                },
                child: const Text('Resume'),
              ),
            ),
            const SizedBox(width: 10),
            Visibility(
              visible:!timerModel.running && timerModel.dirty,
              child: ElevatedButton(
                onPressed: () {
                 finish(timerModel, journeyModel);
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
