package com.mottmac.journeyrec.dao;

import com.mottmac.journeyrec.domain.Journey;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface JourneyRepository extends CrudRepository<Journey, Long> {
}
