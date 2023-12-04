
import 'dart:convert';

import 'journey.dart';
import 'journey_point.dart';

class JourneyComposite {

  Journey journey;
  List<JourneyPoint> journeyPoints;

  JourneyComposite(this.journey, this.journeyPoints);

  Map toJson() => {
    'journey': jsonEncode(journey),
    'points': jsonEncode(journeyPoints),
  };
}