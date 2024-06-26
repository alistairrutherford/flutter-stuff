import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dao/journey.dart';
import '../model/journey_model.dart';
import '../model/location_model.dart';
import '../model/prefs_model.dart';
import '../model/timer_model.dart';
import 'journey_form_page.dart';
import 'map_page.dart';

class JourneyRecordView extends StatefulWidget {
  const JourneyRecordView({super.key});

  @override
  State<JourneyRecordView> createState() => JourneyRecordViewState();
}

/// This is main Journey recording view.
///
class JourneyRecordViewState extends State<JourneyRecordView> {
  String time = "00:00:00";
  static Journey? _journey;
  double _distance = 0.0;

  /// Start Journey.
  ///
  /// Add new journey to database.
  /// Start timer.
  /// Start location stream.
  void start(
      TimerModel timerModel,
      JourneyModel journeyModel,
      LocationModel locationModel,
      SharedPreferencesModel sharedPreferencesModel) async {
    _journey = await journeyModel.addJourney(sharedPreferencesModel.deviceId!);
    locationModel.startPositionStream(_journey, journeyModel);
    timerModel.start();
  }

  /// Pause Journey.
  ///
  /// Pause timer.
  /// Stop location stream.
  void pause(TimerModel timerModel, LocationModel locationModel) {
    timerModel.pause();
    locationModel.endPositionStream();
  }

  /// Resume Journey.
  ///
  /// Resume timer.
  /// Restart location stream.
  void resume(TimerModel timerModel, JourneyModel journeyModel,
      LocationModel locationModel) {
    timerModel.resume();
    locationModel.startPositionStream(_journey, journeyModel);
  }

  /// Finish Journey.
  ///
  /// Stop timer.
  /// Stop location stream.
  /// Update end time in Journey and update in database.
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

  /// Discard Journey.
  ///
  /// Stop timer.
  /// Stop location stream.
  /// Delete Journey and all related JourneyPoints from database.
  void discard(TimerModel timerModel, JourneyModel journeyModel,
      LocationModel locationModel) async {
    timerModel.finish();
    locationModel.endPositionStream();

    await journeyModel.deleteJourney(_journey!);
  }

  @override
  Widget build(BuildContext context) {
    var timerModel = context.watch<TimerModel>();
    var journeyModel = context.watch<JourneyModel>();
    var locationModel = context.watch<LocationModel>();
    var sharedPreferencesModel = context.watch<SharedPreferencesModel>();

    var seconds = timerModel.seconds;
    if (_journey != null) {
      _distance = _journey!.distance;
    }

    // Create callback function which we will give to journey complete form.
    onComplete() {
      finish(timerModel, journeyModel, locationModel);
    }

    // Create callback function which we will give to journey complete form.
    onDiscard() {
      discard(timerModel, journeyModel, locationModel);
    }

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
                journeyModel.formattedTime(timeInSecond: seconds),
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
                visible: true,
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
                    start(timerModel, journeyModel, locationModel, sharedPreferencesModel);
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
                      isScrollControlled: false,
                      context: context,
                      builder: (BuildContext context) {
                        return JourneyFormView(
                          journey: _journey!,
                          onComplete: onComplete,
                          onDiscard: onDiscard,
                        );
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
