import 'package:flutter/material.dart';
import 'package:flutter_db_provider/page/journey_map_page.dart';
import 'package:flutter_db_provider/model/journey_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../dao/journey.dart';

NumberFormat formatter = NumberFormat("00");

class JourneyListView extends StatelessWidget {
  const JourneyListView({super.key});
  static const Map<JourneyType, String> journeyTitles = {
    JourneyType.work: 'Work',
    JourneyType.commute: 'Commute',
    JourneyType.leisure: 'Leisure',
    JourneyType.other: 'Other'
  };

  Icon iconType(Journey journey) {
    return const Icon(
      Icons.access_alarm,
      color: Colors.white,
    );
  }

  /// Format duration of journey,
  ///
  /// We use helper method from the Journey Model. It might be more efficient
  /// to keep this string in the record and display it.
  String elapsedTime(Journey journey, JourneyModel journeyModel) {
    Duration duration = journey.endTime!.difference(journey.startTime);

    return "${journeyModel.formattedTime(timeInSecond: duration.inSeconds)} min";
  }

  Text journeyText(JourneyType journeyType) {
    return Text('${journeyTitles[journeyType]}',
        style: const TextStyle(color: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    var model = context.watch<JourneyModel>();
    var journeys = model.journeys();

    var itemCount = journeys.length;

    return Scaffold(
        appBar: AppBar(
          title: Text('You have ${journeys.length} items:'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10, bottom: 10),
                      leading: const Icon(
                        Icons.directions_bike_outlined,
                        color: Colors.white,
                        size: 60,
                      ),
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              'Commute',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 30),
                            ),
                            const SizedBox(height: 10),
                            Row(mainAxisSize: MainAxisSize.max, children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    const Text('Distance',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20)),
                                    const SizedBox(height: 5),
                                    Text(
                                        "${journeys[index].distance.toStringAsFixed(2)} km",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20))
                                  ]),
                              const SizedBox(width: 40),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    const Text('Time',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20)),
                                    const SizedBox(height: 5),
                                    Text(elapsedTime(journeys[index], model),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20))
                                  ]),
                            ]),
                          ]),
                      tileColor: Colors.blue,
                      trailing: iconType(journeys[index]),
                      onTap: () {
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: Colors.white,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      child: JourneyMapPage(
                                          journeyId: journeys[index].id!),
                                    ),
                                    ElevatedButton(
                                      child: const Text('Close'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    model.removeAll();
                  },
                  child: const Text('Clear'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    model.refresh();
                  },
                  child: const Text('Refresh'),
                ),
              ],
            )
          ],
        ));
  }
}
