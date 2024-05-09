enum JourneyType { commute, work, leisure, other }

/// Journey class represents individual Journey.
///
class Journey {
  int? id;
  String deviceId;
  JourneyType journeyType;
  final DateTime startTime;
  DateTime? endTime;
  int duration = 0;
  double distance = 0;
  bool uploaded = false;

  Journey(
      {this.id,
      required this.deviceId,
      required this.journeyType,
      required this.startTime,
      this.endTime,
      required this.duration,
      required this.distance,
      required this.uploaded});

  /// Convert values to Map.
  ///
  Map<String, dynamic> toMap() {
    int? endTimeMillisecondsSinceEpoch;
    if (endTime != null) {
      endTimeMillisecondsSinceEpoch = endTime!.millisecondsSinceEpoch;
    }

    return {
      'id': id,
      'device_id' : deviceId,
      'journey_type': journeyType.index,
      'start_time': startTime.millisecondsSinceEpoch,
      'end_time': endTimeMillisecondsSinceEpoch,
      'duration': duration,
      'distance': distance,
      'uploaded': uploaded ? 1 : 0
    };
  }

  @override
  String toString() {
    return 'Journey, id: $id, deviceId: $deviceId, journeyType: $journeyType, startTime: $startTime, endTime: $endTime, distance(km): $distance';
  }
}
