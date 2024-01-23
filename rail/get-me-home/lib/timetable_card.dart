import 'package:flutter/material.dart';

class TimeTableCard extends StatelessWidget {
  final String title;
  final String locationName;
  final String origin;
  final String destination;
  final String arrival;
  final String eta;

  TimeTableCard(this.title, this.locationName, this.origin, this.destination, this.arrival, this.eta, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 10, bottom: 10),
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
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
              ),
              const Divider(
                height: 10,
              ),
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
                SizedBox(width: 40),
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
                      SizedBox(height: 5),
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
                      SizedBox(height: 5),
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