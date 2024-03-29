package com.mottmac.journeyrec.domain;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = JourneyPoint.TABLE_NAME)
public class JourneyPoint {
    public static final String TABLE_NAME = "journey_point";

    @Id
    @GeneratedValue
    public long id;

    // Journey id.
    public long journey;

    /// The latitude of this position in degrees normalized to the interval -90.0
    /// to +90.0 (both inclusive).
    public double latitude;

    /// The longitude of the position in degrees normalized to the interval -180
    /// (exclusive) to +180 (inclusive).
    public double longitude;

    /// Timestamp of when point was recorded.
    public long timestamp;

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

    /// The speed at which the devices are traveling in meters per second over
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

    /**
     * Journey Point
     *
     * @param journey
     * @param latitude
     * @param longitude
     * @param timestamp
     * @param accuracy
     * @param altitude
     * @param altitudeAccuracy
     * @param heading
     * @param headingAccuracy
     * @param speed
     * @param speedAccuracy
     */
    @JsonIgnoreProperties(ignoreUnknown = true)
    @JsonCreator
    public JourneyPoint(int journey,
                        double latitude,
                        double longitude,
                        long timestamp,
                        double accuracy,
                        double altitude,
                        @JsonProperty("altitude_accuracy") double altitudeAccuracy,
                        double heading,
                        @JsonProperty("heading_accuracy") double headingAccuracy,
                        double speed,
                        @JsonProperty("speed_accuracy") double speedAccuracy) {
        this.journey = journey;
        this.latitude = latitude;
        this.longitude = longitude;
        this.timestamp = timestamp;
        this.accuracy = accuracy;
        this.altitude = altitude;
        this.altitudeAccuracy = altitudeAccuracy;
        this.heading = heading;
        this.headingAccuracy = headingAccuracy;
        this.speed = speed;
        this.speedAccuracy = speedAccuracy;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getJourney() {
        return journey;
    }

    public void setJourney(long journey) {
        this.journey = journey;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public double getAltitude() {
        return altitude;
    }

    public void setAltitude(double altitude) {
        this.altitude = altitude;
    }

    public double getAltitudeAccuracy() {
        return altitudeAccuracy;
    }

    public void setAltitudeAccuracy(double altitudeAccuracy) {
        this.altitudeAccuracy = altitudeAccuracy;
    }

    public double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(double accuracy) {
        this.accuracy = accuracy;
    }

    public double getHeading() {
        return heading;
    }

    public void setHeading(double heading) {
        this.heading = heading;
    }

    public double getHeadingAccuracy() {
        return headingAccuracy;
    }

    public void setHeadingAccuracy(double headingAccuracy) {
        this.headingAccuracy = headingAccuracy;
    }

    public double getSpeed() {
        return speed;
    }

    public void setSpeed(double speed) {
        this.speed = speed;
    }

    public double getSpeedAccuracy() {
        return speedAccuracy;
    }

    public void setSpeedAccuracy(double speedAccuracy) {
        this.speedAccuracy = speedAccuracy;
    }
}
