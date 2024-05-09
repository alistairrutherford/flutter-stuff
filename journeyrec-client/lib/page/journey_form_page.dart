import 'package:flutter/cupertino.dart';
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
  Widget buildSegment(String text){
      return Text(text,style: const TextStyle(fontSize: 22,
          color: Colors.black));
  }

  @override
  Widget build(BuildContext context) {
    JourneyType journeyType = widget.journey.journeyType;
    int? groupValue = journeyType.index;

    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoSlidingSegmentedControl<int>(
              backgroundColor:  CupertinoColors.white,
              thumbColor: CupertinoColors.activeBlue,
              padding: const EdgeInsets.all(8),
              groupValue: groupValue,
              children: {
                0: buildSegment("Commute"),
                1: buildSegment("Work"),
                2: buildSegment("Leisure"),
                3: buildSegment("Other"),
              },
              onValueChanged: (value){
                setState(() {
                  journeyType = JourneyType.values[value!];
                  widget.journey.journeyType = journeyType;
                  groupValue = value;
                });
              },
            ),
            const SizedBox(height: 40),
            Row(mainAxisSize: MainAxisSize.min, children: [
              ElevatedButton(
                child: const Text('Discard'),
                onPressed: () {
                  widget.onDiscard();
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 20),
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
