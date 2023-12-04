
/// JourneyPoint
class JourneyPoint {
  int? id;

  /// Id of parent Journey.
  final int journey;

  /// The latitude of this position in degrees normalized to the interval -90.0
  /// to +90.0 (both inclusive).
  final double latitude;

  /// The longitude of the position in degrees normalized to the interval -180
  /// (exclusive) to +180 (inclusive).
  final double longitude;

  /// Timestamp of when point was recorded.
  final DateTime timestamp;

  /// The altitude of the device in meters.
  ///
  /// The altitude is not available on all devices. In these cases the returned
  /// value is 0.0.
  final double altitude;

  /// The estimated vertical accuracy of the position in meters.
  ///
  /// The accuracy is not available on all devices. In these cases the value is
  /// 0.0.
  final double altitudeAccuracy;

  /// The estimated horizontal accuracy of the position in meters.
  ///
  /// The accuracy is not available on all devices. In these cases the value is
  /// 0.0.
  final double accuracy;

  /// The heading in which the device is traveling in degrees.
  ///
  /// The heading is not available on all devices. In these cases the value is
  /// 0.0.
  final double heading;

  /// The estimated heading accuracy of the position in degrees.
  ///
  /// The heading accuracy is not available on all devices. In these cases the
  /// value is 0.0.
  final double headingAccuracy;

  /// The speed at which the devices is traveling in meters per second over
  /// ground.
  ///
  /// The speed is not available on all devices. In these cases the value is
  /// 0.0.
  final double speed;

  /// The estimated speed accuracy of this position, in meters per second.
  ///
  /// The speedAccuracy is not available on all devices. In these cases the
  /// value is 0.0.
  final double speedAccuracy;

  JourneyPoint(
      {this.id,
      required this.journey,
      required this.latitude,
      required this.longitude,
      required this.timestamp,
      required this.accuracy,
      required this.altitude,
      required this.altitudeAccuracy,
      required this.heading,
      required this.headingAccuracy,
      required this.speed,
      required this.speedAccuracy});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'journey': journey,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.microsecondsSinceEpoch,
      'accuracy': accuracy,
      'altitude': altitude,
      'altitude_accuracy': altitudeAccuracy,
      'heading': heading,
      'heading_accuracy':headingAccuracy,
      'speed': speed,
      'speed_accuracy': speedAccuracy
    };
  }

  Map toJson() {
    return {
      'id': id,
      'journey': journey,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.microsecondsSinceEpoch,
      'accuracy': accuracy,
      'altitude': altitude,
      'altitude_accuracy': altitudeAccuracy,
      'heading': heading,
      'heading_accuracy':headingAccuracy,
      'speed': speed,
      'speed_accuracy': speedAccuracy
    };
  }

  @override
  String toString() {
    return 'JourneyPoint{id: $id, route: $journey, latitude: $latitude, longitude: $longitude';
  }
}
