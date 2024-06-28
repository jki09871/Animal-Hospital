package com.review.controller.animal;

import com.review.dto.animal.AnimalAdoptionDTO;
import com.review.service.animal.AnimalAdoptionService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class AnimalAdoptionController {

    @Setter(onMethod_ = @Autowired)
    private AnimalAdoptionService adoptionService;

    @GetMapping("/adoption/animal/register")
    public String adoptionAnimalRegister(AnimalAdoptionDTO adoptionDTO){
        adoptionService.adoptionAnimalRegister(adoptionDTO);
    }
}
