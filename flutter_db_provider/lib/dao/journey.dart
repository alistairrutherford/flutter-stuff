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
    return {
      'id': id,
      'journeyType': journeyType,
      'startTime': startTime,
      'endTime': endTime
    };
  }
}
