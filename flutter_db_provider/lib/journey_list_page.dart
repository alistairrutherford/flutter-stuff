import 'package:flutter/material.dart';
import 'package:flutter_db_provider/journey_model.dart';
import 'package:provider/provider.dart';

import 'dao/journey.dart';

class JourneyListView extends StatelessWidget {
  const JourneyListView({super.key});

  Icon iconType(Journey journey) {
    return Icon(Icons.access_alarm);
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
                      leading: const Icon(Icons.directions_bike_outlined),
                      title: Text('Route: ${journeys[index].toString()}'),
                      tileColor: Colors.blue,
                      trailing: iconType(journeys[index]),
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
