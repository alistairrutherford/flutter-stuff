import 'package:flutter/material.dart';
import 'package:flutter_db_provider/model/journey_model.dart';
import 'package:flutter_db_provider/model/location_model.dart';
import 'package:flutter_db_provider/page/journey_form_page.dart';
import 'package:flutter_db_provider/page/map_page.dart';
import 'package:flutter_db_provider/model/timer_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../dao/journey.dart';

class JourneyRecordView extends StatefulWidget {
  const JourneyRecordView({super.key});

  @override
  State<JourneyRecordView> createState() => JourneyRecordViewState();
}

class JourneyRecordViewState extends State<JourneyRecordView> {
  String time = "00:00:00";
  NumberFormat formatter = NumberFormat("00");
  Journey? _journey;
  double _distance = 0.0;

  String formattedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    int hour = (timeInSecond / 3600).floor();
    return "${formatter.format(hour)}:${formatter.format(min)}:${formatter.format(sec)}";
  }

  void start(TimerModel timerModel, JourneyModel journeyModel,
      LocationModel locationModel) async {
    _journey = await journeyModel.addJourney();
    locationModel.startPositionStream(_journey, journeyModel);
    timerModel.start();
  }

  void pause(TimerModel timerModel, LocationModel locationModel) {
    timerModel.pause();
    locationModel.endPositionStream();
  }

  void resume(TimerModel timerModel, JourneyModel journeyModel,
      LocationModel locationModel) {
    timerModel.resume();
    locationModel.startPositionStream(_journey, journeyModel);
  }

  void test(TimerModel timerModel)  {

  }

  void finish(TimerModel timerModel, JourneyModel journeyModel,
      LocationModel locationModel) async {
    timerModel.finish();
    locationModel.endPositionStream();

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
    var locationModel = context.watch<LocationModel>();

    var seconds = timerModel.seconds;
    if (_journey != null) {
      _distance = _journey!.distance;
    }

    // Create callback function which we will give to journey complete form.
    void Function() onComplete = () {
      finish(timerModel, journeyModel, locationModel);
    };

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            height: timerModel.running || timerModel.dirty
                ? (constraints.maxHeight * 0.60)
                : 0.0,
            alignment: timerModel.running
                ? Alignment.center
                : AlignmentDirectional.topCenter,
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            child: const MapPage(),
          ),
          Expanded(
            child: Center(
              child: Text(
                formattedTime(timeInSecond: seconds),
                style: TextStyle(
                  fontSize: (constraints.maxHeight /
                      8), // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Center(
              child: Visibility(
                visible: _journey != null,
                child: Text(
                  'Dist: ${_distance.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: (constraints.maxHeight /
                        15), // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                  ),
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
                    start(timerModel, journeyModel, locationModel);
                  },
                  child: const Text('Start'),
                ),
              ),
              Visibility(
                visible: timerModel.running,
                child: ElevatedButton(
                  onPressed: () {
                    pause(timerModel, locationModel);
                  },
                  child: const Text('Pause'),
                ),
              ),
              Visibility(
                visible: !timerModel.running && timerModel.dirty,
                child: ElevatedButton(
                  onPressed: () {
                    resume(timerModel, journeyModel, locationModel);
                  },
                  child: const Text('Resume'),
                ),
              ),
              const SizedBox(width: 10),
              Visibility(
                visible: !timerModel.running && timerModel.dirty,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return JourneyFormView(journey: _journey!, onPressed: onComplete);
                      },
                    );
                  },
                  child: const Text('Finish'),
                ),
              ),
            ],
          )
        ],
      );
    });
    // Format seconds
  }
}
