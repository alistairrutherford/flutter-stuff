import 'package:flutter/material.dart';

import '../dao/journey.dart';

class JourneyFormView extends StatefulWidget {
  final Journey journey;
  final Function() onComplete;
  final Function() onDiscard;

  const JourneyFormView(
      {super.key,
      required this.journey,
      required this.onComplete(),
      required this.onDiscard()});

  @override
  State<JourneyFormView> createState() => JourneyFormViewState();
}

class JourneyFormViewState extends State<JourneyFormView> {
  @override
  Widget build(BuildContext context) {
    JourneyType _journeyType = widget.journey.journeyType;

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SegmentedButton<JourneyType>(
              segments: const <ButtonSegment<JourneyType>>[
                ButtonSegment<JourneyType>(
                    value: JourneyType.commute,
                    label: Text('Commute'),
                    /*icon: Icon(Icons.motorcycle)*/),
                ButtonSegment<JourneyType>(
                    value: JourneyType.leisure,
                    label: Text('Leisure'),
                    /*icon: Icon(Icons.motorcycle)*/),
                ButtonSegment<JourneyType>(
                    value: JourneyType.work,
                    label: Text('Work'),
                    /*icon: Icon(Icons.motorcycle)*/),
                ButtonSegment<JourneyType>(
                    value: JourneyType.other,
                    label: Text('Other'),
                    /*icon: Icon(Icons.motorcycle)*/),
              ],
              selected: <JourneyType>{_journeyType},
              onSelectionChanged: (Set<JourneyType> newSelection) {
                setState(() {
                  // By default there is only a single segment that can be
                  // selected at one time, so its value is always the first
                  // item in the selected set.
                  _journeyType = newSelection.first;
                  widget.journey.journeyType = _journeyType;
                });
              },
            ),
            Row(mainAxisSize: MainAxisSize.min, children: [
              ElevatedButton(
                child: const Text('Discard'),
                onPressed: () {
                  widget.onDiscard();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                child: const Text('Complete'),
                onPressed: () {
                  widget.onComplete();
                  Navigator.pop(context);
                },
              ),
            ])
          ],
        ),
      ),
    );
  }
}
