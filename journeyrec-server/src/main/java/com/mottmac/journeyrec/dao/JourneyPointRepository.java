package com.mottmac.journeyrec.dao;

import com.mottmac.journeyrec.domain.JourneyPoint;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface JourneyPointRepository extends CrudRepository<JourneyPoint, Integer> {
    List<JourneyPoint> fetchJourneyPoints();
}
