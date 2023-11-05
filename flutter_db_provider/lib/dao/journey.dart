enum JourneyType { work, commute, leisure, other }

/// Journey class represents individual Journey.
///
class Journey {
  int? id;
  final JourneyType journeyType;
  final DateTime startTime;
  DateTime? endTime;
  double distance = 0;

  Journey(
      {this.id,
      required this.journeyType,
      required this.startTime,
      this.endTime});

  Map<String, dynamic> toMap() {
    int? endTimeMillisecondsSinceEpoch;
    if (endTime != null) {
      endTimeMillisecondsSinceEpoch = endTime!.millisecondsSinceEpoch;
    }

    return {
      'id': id,
      'journey_type': journeyType.index,
      'start_time': startTime.millisecondsSinceEpoch,
      'end_time': endTimeMillisecondsSinceEpoch,
      'distance': distance
    };
  }

  @override
  String toString() {
    return 'Journey{id: $id, journeyType: $journeyType, startTime: $startTime, endTime: $endTime, distance(km): $distance';
  }
}
