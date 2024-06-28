package com.review.service.animal;

import com.review.dto.animal.AnimalAdoptionDTO;
import com.review.repository.animal.AnimalAdoptionRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AnimalAdoptionService {

    @Setter(onMethod_ = @Autowired)
    private AnimalAdoptionRepository adoptionRepository;


    public void adoptionAnimalRegister(AnimalAdoptionDTO adoptionDTO) {
        adoptionRepository.adoptionAnimalRegister(adoptionDTO);
    }
}
