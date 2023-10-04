import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'journey_point_model.dart';

class JourneyListView extends StatelessWidget {
  const JourneyListView({super.key});

  @override
  Widget build(BuildContext context) {
    var model = context.watch<JourneyPointModel>();
    var locations = model.locations();

    var itemCount = locations.length;

    return Scaffold(
        appBar: AppBar(
          title: Text('You have ${locations.length} items:'),
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
                      leading: const Icon(Icons.favorite),
                      title: Text('Route: ${locations[index].toString()}'),
                      tileColor: Colors.blue,
                      trailing: const Icon(Icons.access_alarm),
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
                    model.addPoint();
                  },
                  child: Text('Add'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    model.removeAll();
                  },
                  child: const Text('Clear'),
                ),
              ],
            )
          ],
        ));
  }
}
