package com.mottmac.journeyrec.controller;

import com.mottmac.journeyrec.dao.JourneyRepository;
import com.mottmac.journeyrec.domain.Journey;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class JourneyController {
    private final JourneyRepository repository;

    public JourneyController(JourneyRepository repository) {
        this.repository = repository;
    }

    @GetMapping("/Journeys")
    Iterable<Journey> all() {
        return repository.findAll();
    }
    // end::get-aggregate-root[]

    @PostMapping("/Journeys")
    Journey newJourney(@RequestBody Journey newJourney) {
        return repository.save(newJourney);
    }

    // Single item

    @GetMapping("/Journeys/{id}")
    Journey one(@PathVariable Long id) throws JourneyNotFoundException {

        return repository.findById(id)
                .orElseThrow(() -> new JourneyNotFoundException(id));
    }

    @PutMapping("/Journeys/{id}")
    Journey replaceJourney(@RequestBody Journey newJourney, @PathVariable Long id) {

        return repository.findById(id)
                .map(Journey -> {
                    Journey.setJourneyType(newJourney.getJourneyType());
                    Journey.setDistance(newJourney.getDistance());
                    // TODO and the rest
                    return repository.save(Journey);
                })
                .orElseGet(() -> {
                    newJourney.setId(id);
                    return repository.save(newJourney);
                });
    }

    @DeleteMapping("/Journeys/{id}")
    void deleteJourney(@PathVariable Long id) {
        repository.deleteById(id);
    }
}
