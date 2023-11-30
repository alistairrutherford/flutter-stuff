package com.mottmac.journeyrec.domain;

import java.util.List;

public class JourneyComposite {
    private Journey journey;
    private List<JourneyPoint> journeyPoints;

    public JourneyComposite(Journey journey, List<JourneyPoint> journeyPoints) {
        this.journey = journey;
        this.journeyPoints = journeyPoints;
    }

    public Journey getJourney() {
        return journey;
    }

    public void setJourney(Journey journey) {
        this.journey = journey;
    }

    public List<JourneyPoint> getJourneyPoints() {
        return journeyPoints;
    }

    public void setJourneyPoints(List<JourneyPoint> journeyPoints) {
        this.journeyPoints = journeyPoints;
    }
}
