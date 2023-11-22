package com.mottmac.journeyrec.controller;

import com.mottmac.journeyrec.dao.JourneyPointRepository;
import com.mottmac.journeyrec.dao.JourneyRepository;
import com.mottmac.journeyrec.domain.Journey;
import com.mottmac.journeyrec.domain.JourneyPoint;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class JourneyController {
    private final JourneyRepository journeyRepository;
    private final JourneyPointRepository journeyPointRepository;

    public JourneyController(JourneyRepository journeyRepository, JourneyPointRepository journeyPointRepository) {
        this.journeyRepository = journeyRepository;
        this.journeyPointRepository = journeyPointRepository;
    }

    @GetMapping("/Journeys")
    public Iterable<Journey> all() {
        return journeyRepository.findAll();
    }
    // end::get-aggregate-root[]

    @PostMapping("/Journeys")
    public Journey addJourney(@RequestBody Journey newJourney) {
        return journeyRepository.save(newJourney);
    }

    @PostMapping("/JourneyPoints")
    public void  addJourneyPoints(@RequestBody List<JourneyPoint> points) {
        for (JourneyPoint journeyPoint: points) {
            journeyPointRepository.save(journeyPoint);
        }
    }

    // Single item

    @GetMapping("/Journeys/{id}")
    public Journey one(@PathVariable Long id) throws JourneyNotFoundException {

        return journeyRepository.findById(id)
                .orElseThrow(() -> new JourneyNotFoundException(id));
    }

    @PutMapping("/Journeys/{id}")
    public Journey replaceJourney(@RequestBody Journey newJourney, @PathVariable Long id) {

        return journeyRepository.findById(id)
                .map(Journey -> {
                    Journey.setJourneyType(newJourney.getJourneyType());
                    Journey.setDistance(newJourney.getDistance());
                    // TODO and the rest
                    return journeyRepository.save(Journey);
                })
                .orElseGet(() -> {
                    newJourney.setId(id);
                    return journeyRepository.save(newJourney);
                });
    }

    @DeleteMapping("/Journeys/{id}")
    public void deleteJourney(@PathVariable Long id) {
        journeyRepository.deleteById(id);
    }
}
