import 'package:flutter/material.dart';
import 'package:get_me_home/dao/callingpoint.dart';

class TimeTableCard extends StatelessWidget {

  final String locationName;
  final TrainService trainService;

  const TimeTableCard(this.locationName, this.trainService, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO Refactor this to tidy it up.
    String origin;
    String destination;
    String? arrival;
    String? eta;

    Origin? org = trainService.origin![0];
    origin = org!.locationName ?? "---";
    Destination? dest = trainService.destination![0];
    destination = dest!.locationName ?? "---";
    arrival = trainService.sta ?? trainService.std;
    eta = trainService.eta ?? trainService.etd;
    arrival = arrival ?? "---";
    eta = eta ?? "---";

    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 10),
        leading: const Icon(
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
                locationName,
                style: const TextStyle(
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
                      const Text('Origin',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20)),
                      const SizedBox(height: 5),
                      Text(origin,
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
                      const Text('Destination',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20)),
                      const SizedBox(height: 5),
                      Text(destination,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20))
                    ]),
              ]),
              const Divider(
                height: 10,
              ),
              Row(mainAxisSize: MainAxisSize.max, children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const Text('Arrival',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20)),
                      const SizedBox(height: 5),
                      Text(arrival,
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
                      const Text('ETA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20)),
                      const SizedBox(height: 5),
                      Text(eta,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20))
                    ]),
              ]),
            ]),
        tileColor: Colors.blue,
        trailing: const Icon(
          Icons.upload_file,
          color: Colors.white,
        ),
      ),
    );
  }
}
