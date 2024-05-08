package com.review.service;

import com.review.dto.PetDTO;
import com.review.repository.PetRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.List;

@Log4j
@Service
@RequiredArgsConstructor
public class PetService {

    @Setter(onMethod_ = @Autowired)
    private PetRepository pr;
    public void petInfoSave(PetDTO petDTO) {
        pr.petInfoSave(petDTO);
    }

    public List<PetDTO> getPetInfo(String ownerId) {
        return pr.getPetInfo(ownerId);
    }

    public PetDTO petInfoModify(String pet_Id) {
        return pr.petINfoModify(pet_Id);
    }

    public void petInfoUpdate(PetDTO petDTO) {
        pr.petInfoUpdate(petDTO);
    }

    public void petInfoDelete(String pet_Id) {
        pr.petInfoDelete(pet_Id);
    }
}
