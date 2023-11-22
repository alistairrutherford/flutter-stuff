package com.mottmac.journeyrec.dao;

import com.mottmac.journeyrec.domain.Journey;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface JourneyRepository extends CrudRepository<Journey, Integer> {
    List<Journey> fetchJourneys();
    public Journey findByJourneyId(int journeyId);
}
