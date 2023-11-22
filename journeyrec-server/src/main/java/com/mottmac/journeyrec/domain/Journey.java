package com.mottmac.journeyrec.domain;


import java.time.LocalDateTime;

public class Journey {
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
