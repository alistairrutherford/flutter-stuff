package com.mottmac.journeyrec.service;

import com.mottmac.journeyrec.dao.JourneyPointRepository;
import com.mottmac.journeyrec.dao.JourneyRepository;
import com.mottmac.journeyrec.domain.Journey;
import com.mottmac.journeyrec.domain.JourneyPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class JourneyService {

    @Autowired
    private JourneyRepository journeyRepository;

    @Autowired
    private JourneyPointRepository journeyPointRepository;

    public boolean saveJourney(Journey journey, List<JourneyPoint> journeyPoints) {
        try {
            journeyRepository.save(journey);
            for (JourneyPoint point : journeyPoints) {

            }
        }
        catch (Exception e) {

        }
    }
}
