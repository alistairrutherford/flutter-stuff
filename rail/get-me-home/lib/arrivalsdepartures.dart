import 'package:flutter/material.dart';
import 'package:get_me_home/model/timetable_model.dart';
import 'package:provider/provider.dart';

import 'model/network_model.dart';

class ArrivalsDeparturesView extends StatelessWidget {
  const ArrivalsDeparturesView({super.key});

  @override
  Widget build(BuildContext context) {
    var timeTableModel = context.watch<TimeTableModel>();

    var arrivals = timeTableModel.arrivals;
    var departures = timeTableModel.departures;

    return _StatefulWrapper(
      onInit: () {
        var networkModel = context.watch<NetworkModel>();
        timeTableModel.initialise(networkModel);
      },
      child: Material(
        child: Container(
          color: Colors.indigo,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 10),
                  leading: Icon(
                    Icons.train,
                    color: Colors.white,
                    size: 60,
                  ),
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Arrivals",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 30),
                        ),
                        SizedBox(height: 10),
                        Row(mainAxisSize: MainAxisSize.max, children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('Origin',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20)),
                                SizedBox(height: 5),
                                Text("Milngavie",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20))
                              ]),
                          SizedBox(width: 40),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('Destination',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20)),
                                SizedBox(height: 5),
                                Text("Motherwell",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20))
                              ]),
                        ]),
                        Divider(
                          height: 10,
                        ),
                        Row(mainAxisSize: MainAxisSize.max, children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('Arrival',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20)),
                                SizedBox(height: 5),
                                Text("12:00:00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20))
                              ]),
                          SizedBox(width: 40),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text('ETA',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20)),
                                SizedBox(height: 5),
                                Text("12:00:02",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20))
                              ]),
                        ]),
                      ]),
                  tileColor: Colors.blue,
                  trailing: Icon(
                    Icons.upload_file,
                    color: Colors.white,
                  ),
                ),
              ),
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
