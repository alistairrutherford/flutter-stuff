package com.mottmac.journeyrec.controller;

import com.mottmac.journeyrec.domain.JourneyComposite;
import com.mottmac.journeyrec.service.JourneyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class JourneyController {
    private final JourneyService journeyService;

    @Autowired
    public JourneyController(JourneyService journeyService) {
        this.journeyService = journeyService;
    }

    @PostMapping("/journey")
    public void addJourney(@RequestBody JourneyComposite journey) {
       journeyService.save(journey);
    }

    @GetMapping("/ping")
    public String ping() {
        return "pong";
    }
}
