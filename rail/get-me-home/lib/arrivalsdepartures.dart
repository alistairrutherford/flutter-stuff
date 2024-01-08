import 'package:flutter/material.dart';

class ArrivalsDeparturesView extends StatelessWidget {
  const ArrivalsDeparturesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
        children: [
          Card(child: Text("Arrivals"),),
          Card(child: Text("Departures"),)
        ],
    ));
  }
}