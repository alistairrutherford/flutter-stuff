package com.mottmac.journeyrec.controller;

import com.mottmac.journeyrec.domain.Journey;
import com.mottmac.journeyrec.domain.JourneyComposite;
import com.mottmac.journeyrec.service.JourneyService;
import org.springframework.web.bind.annotation.*;

@RestController
public class JourneyController {
    private final JourneyService journeyService;

    public JourneyController(JourneyService journeyService) {
        this.journeyService = journeyService;
    }

    @PostMapping("/Journey")
    public void addJourney(@RequestBody JourneyComposite journey) {
       journeyService.save(journey);
    }
}
