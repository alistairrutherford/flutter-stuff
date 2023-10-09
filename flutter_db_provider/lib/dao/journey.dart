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
    int? endTimeMillisecondsSinceEpoch = (endTime != null ?? endTime!.millisecondsSinceEpoch) as int?;

    return {
      'id': id,
      'journeyType': journeyType.index,
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTimeMillisecondsSinceEpoch
    };
  }
}
