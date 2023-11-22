package com.mottmac.journeyrec.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.time.LocalDateTime;

@Entity
@Table(name = Journey.TABLE_NAME)
public class Journey {
    public static final String TABLE_NAME = "journey";

    public enum JourneyType { commute, work, leisure, other };

    public int id;
    public JourneyType journeyType;
    public LocalDateTime startTime;
    public LocalDateTime endTime;
    public int duration = 0;
    public double distance = 0;

    /**
     * Journey.
     *
     * @param id
     * @param journeyType
     * @param startTime
     * @param endTime
     * @param duration
     * @param distance
     */
    public void JourneyType(int id,
                            JourneyType journeyType,
                            LocalDateTime startTime,
                            LocalDateTime endTime,
                            int duration,
                            double distance) {
        this.id = id;
        this.journeyType = journeyType;
        this.startTime = startTime;
        this.endTime = endTime;
        this.duration = duration;
        this.distance = distance;
    }
}
