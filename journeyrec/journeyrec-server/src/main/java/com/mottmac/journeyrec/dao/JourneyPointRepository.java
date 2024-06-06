package com.mottmac.journeyrec.dao;

import com.mottmac.journeyrec.domain.JourneyPoint;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface JourneyPointRepository extends CrudRepository<JourneyPoint, Long> {

}
