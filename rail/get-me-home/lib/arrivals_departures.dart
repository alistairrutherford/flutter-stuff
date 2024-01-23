import 'package:flutter/material.dart';
import 'package:get_me_home/model/timetable_model.dart';
import 'package:get_me_home/timetable_card.dart';
import 'package:provider/provider.dart';

import 'model/network_model.dart';

class ArrivalsDeparturesView extends StatelessWidget {
  const ArrivalsDeparturesView({super.key});

  @override
  Widget build(BuildContext context) {
    var timeTableModel = context.watch<TimeTableModel>();

    return _StatefulWrapper(
      onInit: () {
        var networkModel = context.watch<NetworkModel>();
        timeTableModel.initialise(networkModel);
      },
      child: Material(
        child: Container(
          color: Colors.indigo,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TimeTableCard('Arrival',
                  timeTableModel.arrivals!.locationName!,
                  timeTableModel.arrivalTrainServiceDetails.origin,
                  timeTableModel.arrivalTrainServiceDetails.destination,
                  timeTableModel.arrivalTrainServiceDetails.arrival,
                  timeTableModel.arrivalTrainServiceDetails.eta),
              TimeTableCard('Departures',
                  timeTableModel.departures!.locationName!,
                  timeTableModel.departureTrainServiceDetails.origin,
                  timeTableModel.departureTrainServiceDetails.destination,
                  timeTableModel.departureTrainServiceDetails.arrival,
                  timeTableModel.departureTrainServiceDetails.eta)
            ],
          ),
        ),
      ),
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
