package com.mottmac.journeyrec.domain;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

@Entity
@Table(name = Journey.TABLE_NAME)
public class Journey {
    public static final String TABLE_NAME = "journey";

    public enum JourneyType { commute, work, leisure, other };

    @Id
    @GeneratedValue
    public long id;
    public String deviceId;
    public String journey_type;
    public long start_time;
    public long end_time;
    public int duration = 0;
    public double distance = 0;

    public Journey() {

    }


    /**
     * Journey.
     *
     * @param id
     * @param deviceId
     * @param journeyType
     * @param startTime
     * @param endTime
     * @param duration
     * @param distance
     * @param uploaded
     */
    @JsonIgnoreProperties(ignoreUnknown = true)
    @JsonCreator
    public Journey(int id,
                   @JsonProperty("device_id") String deviceId,
                   String journeyType,
                   long startTime,
                   long endTime,
                   int duration,
                   double distance,
                   boolean uploaded) {
        this.id = id;
        this.deviceId = deviceId;
        this.journey_type = journeyType;
        this.start_time = startTime;
        this.end_time = endTime;
        this.duration = duration;
        this.distance = distance;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDeviceId() { return deviceId; }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getJourney_type() {
        return journey_type;
    }

    public void setJourney_type(String journey_type) {
        this.journey_type = journey_type;
    }

    public long getStart_time() {
        return start_time;
    }

    public void setStart_time(long start_time) {
        this.start_time = start_time;
    }

    public long getEnd_time() {
        return end_time;
    }

    public void setEnd_time(long end_time) {
        this.end_time = end_time;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public double getDistance() {
        return distance;
    }

    public void setDistance(double distance) {
        this.distance = distance;
    }
}
