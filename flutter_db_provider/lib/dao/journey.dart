enum JourneyType { work, commute, leisure, other }

class Journey {
  int? id;
  final JourneyType journeyType;
  final DateTime startTime;
  DateTime? endTime;

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
      'end_time': endTimeMillisecondsSinceEpoch
    };
  }

  @override
  String toString() {
    return 'Journey{id: $id, journeyType: $journeyType, startTime: $startTime, endTime: $endTime';
  }
}
