import 'package:flutter/material.dart';
import 'package:get_me_home/model/prefs_model.dart';
import 'package:get_me_home/model/stations_model.dart';
import 'package:get_me_home/model/timetable_model.dart';
import 'package:get_me_home/timetable_card.dart';
import 'package:provider/provider.dart';

import 'model/network_model.dart';

class ArrivalsDeparturesView extends StatelessWidget {
  const ArrivalsDeparturesView({super.key});

  @override
  Widget build(BuildContext context) {
    var timeTableModel = context.watch<TimeTableModel>();

    var trainServices = timeTableModel.trainServices;
    int itemCount = trainServices.length;

    return _StatefulWrapper(
      onInit: () async {
        // Initialise models in sequence.
        var preferencesModel = context.watch<SharedPreferencesModel>();
        var networkModel = context.watch<NetworkModel>();
        var stationsModel = context.watch<StationsModel>();

        await preferencesModel.initialise();
        await networkModel.initialise(preferencesModel);
        await stationsModel.initialise();
        timeTableModel.initialise(networkModel);
      },
      child: Material(
          child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: itemCount,
                      itemBuilder: (BuildContext context, int index) {
                        return TimeTableCard(trainServices[index]!.locationName,
                            trainServices[index]!.trainService);
                      },
                    ),
                  ),
                ],
              ))),
    );
  }
}

/// StatefulWrapper provides a call back mechanism for StateLess widgets to perform
/// initialisation.
///
class _StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const _StatefulWrapper({required this.onInit, required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<_StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
