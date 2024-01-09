import 'package:flutter/material.dart';

class ArrivalsDeparturesView extends StatelessWidget {
  const ArrivalsDeparturesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Card(
          child: Text("Arrivals"),
        )),
        Expanded(
            child: Card(
          child: Text("Departures"),
        )),
      ],
    ));
  }
}
