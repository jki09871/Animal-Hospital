package com.review.service.animal;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.dto.animal.PetDTO;
import com.review.repository.animal.ManagerRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j
public class ManagerService {

    @Setter(onMethod_ = @Autowired)
    private ManagerRepository mr;

    public List<AnimalMemberDTO> memberList() {
       return mr.memberList();

    }

    public List<PetDTO> animalList() {
        return mr.petList();
    }
}
