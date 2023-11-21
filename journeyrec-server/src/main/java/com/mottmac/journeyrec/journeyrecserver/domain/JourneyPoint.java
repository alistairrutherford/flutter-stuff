package com.mottmac.journeyrec.journeyrecserver.domain;

import java.time.LocalDateTime;

public class JourneyPoint {
    public int id;

    /// Id of parent Journey.
    public int journey;

    /// The latitude of this position in degrees normalized to the interval -90.0
    /// to +90.0 (both inclusive).
    public double latitude;

    /// The longitude of the position in degrees normalized to the interval -180
    /// (exclusive) to +180 (inclusive).
    public double longitude;

    /// Timestamp of when point was recorded.
    public LocalDateTime timestamp;

    /// The altitude of the device in meters.
    ///
    /// The altitude is not available on all devices. In these cases the returned
    /// value is 0.0.
    public double altitude;

    /// The estimated vertical accuracy of the position in meters.
    ///
    /// The accuracy is not available on all devices. In these cases the value is
    /// 0.0.
    public double altitudeAccuracy;

    /// The estimated horizontal accuracy of the position in meters.
    ///
    /// The accuracy is not available on all devices. In these cases the value is
    /// 0.0.
    public double accuracy;

    /// The heading in which the device is traveling in degrees.
    ///
    /// The heading is not available on all devices. In these cases the value is
    /// 0.0.
    public double heading;

    /// The estimated heading accuracy of the position in degrees.
    ///
    /// The heading accuracy is not available on all devices. In these cases the
    /// value is 0.0.
    public double headingAccuracy;

    /// The speed at which the devices is traveling in meters per second over
    /// ground.
    ///
    /// The speed is not available on all devices. In these cases the value is
    /// 0.0.
    public double speed;

    /// The estimated speed accuracy of this position, in meters per second.
    ///
    /// The speedAccuracy is not available on all devices. In these cases the
    /// value is 0.0.
    public double speedAccuracy;

    public void JourneyPoint(int id,
                             int journey,
                             double latitude,
                             double longitude,
                             LocalDateTime timestamp,
                             double accuracy,
                             double altitude,
                             double altitudeAccuracy,
                             double heading,
                             double headingAccuracy,
                             double speed,
                             double speedAccuracy) {
        this.id = id;
        this.journey = journey;
        this.latitude = latitude;
        this.longitude = longitude;
        this.timestamp = timestamp;
        this.accuracy = accuracy;
        this.altitude = altitude;
        this.altitudeAccuracy = altitudeAccuracy;

    }
}
