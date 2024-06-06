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
    public String journeyType;
    public long startTime;
    public long endTime;
    public int duration = 0;
    public double distance = 0;

    public Journey() {

    }



    /**
     * Journey.
     * Note we only need JsonProperty for where the field name doesn't match
     * the incoming parameter.
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
                   @JsonProperty("journey_type") String journeyType,
                   @JsonProperty("start_time") long startTime,
                   @JsonProperty("end_time") long endTime,
                   int duration,
                   double distance,
                   boolean uploaded) {
        this.id = id;
        this.deviceId = deviceId;
        this.journeyType = journeyType;
        this.startTime = startTime;
        this.endTime = endTime;
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

    public String getJourneyType() {
        return journeyType;
    }

    public void setJourneyType(String journeyType) {
        this.journeyType = journeyType;
    }

    public long getStartTime() {
        return startTime;
    }

    public void setStartTime(long startTime) {
        this.startTime = startTime;
    }

    public long getEndTime() {
        return endTime;
    }

    public void setEndTime(long endTime) {
        this.endTime = endTime;
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
