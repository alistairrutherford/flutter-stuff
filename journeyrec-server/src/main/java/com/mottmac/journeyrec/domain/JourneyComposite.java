package com.mottmac.journeyrec.domain;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class JourneyComposite {
    private Journey journey;
    private List<JourneyPoint> points;

    public JourneyComposite() {
        // Empty constructor.
    }

    @JsonIgnoreProperties(ignoreUnknown = true)
    @JsonCreator
    public JourneyComposite(@JsonProperty("journey") Journey journey, @JsonProperty("points") List<JourneyPoint> points) {
        this.journey = journey;
        this.points = points;
    }

    public Journey getJourney() {
        return journey;
    }

    public void setJourney(Journey journey) {
        this.journey = journey;
    }

    public List<JourneyPoint> getPoints() {
        return points;
    }

    public void setPoints(List<JourneyPoint> points) {
        this.points = points;
    }
}
