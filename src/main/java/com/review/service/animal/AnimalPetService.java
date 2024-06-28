package com.review.service.animal;

import com.review.dto.animal.AnimalDTO;
import com.review.repository.animal.AnimalPetRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@RequiredArgsConstructor
public class AnimalPetService {

    @Setter(onMethod_ = @Autowired)
    private AnimalPetRepository pr;
    public void petInfoSave(AnimalDTO petDTO) {
        pr.petInfoSave(petDTO);
    }

    public List<AnimalDTO> getPetInfo(String ownerId) {
        return pr.getPetInfo(ownerId);
    }

    public AnimalDTO petInfoModify(String pet_Id) {
        return pr.petINfoModify(pet_Id);
    }

    public void petInfoUpdate(AnimalDTO petDTO) {
        pr.petInfoUpdate(petDTO);
    }

    public void petInfoDelete(String pet_Id) {
        pr.petInfoDelete(pet_Id);
    }
}
