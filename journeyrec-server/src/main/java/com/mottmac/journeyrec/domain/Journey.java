package com.mottmac.journeyrec.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

import java.time.LocalDateTime;

@Entity
@Table(name = Journey.TABLE_NAME)
public class Journey {
    public static final String TABLE_NAME = "journey";

    public enum JourneyType { commute, work, leisure, other };

    @Id
    @GeneratedValue
    public long id;
    public JourneyType journeyType;
    public LocalDateTime startTime;
    public LocalDateTime endTime;
    public int duration = 0;
    public double distance = 0;

    /**
     * Journey.
     *
     * @param journeyType
     * @param startTime
     * @param endTime
     * @param duration
     * @param distance
     */
    public Journey(
                   JourneyType journeyType,
                   LocalDateTime startTime,
                   LocalDateTime endTime,
                   int duration,
                   double distance) {
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

    public JourneyType getJourneyType() {
        return journeyType;
    }

    public void setJourneyType(JourneyType journeyType) {
        this.journeyType = journeyType;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
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
