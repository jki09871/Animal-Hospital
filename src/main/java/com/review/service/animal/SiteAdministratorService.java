package com.review.service.animal;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.dto.animal.PetDTO;
import com.review.paging.PagingCriteria;
import com.review.repository.animal.SiteAdministratorRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j
public class SiteAdministratorService {

    @Setter(onMethod_ = @Autowired)
    private SiteAdministratorRepository mr;

    public List<AnimalMemberDTO> memberList() {
       return mr.memberList();

    }
    public AnimalMemberDTO memberData(AnimalMemberDTO memberDTO) {
        return mr.memberData(memberDTO);
    }

    public List<PetDTO> animalList(PagingCriteria cri) {
        return mr.petList(cri);
    }

    public PetDTO petData(PetDTO petDTO) {
        return mr.petData(petDTO);
    }

    public int postTotal(PagingCriteria cri) {
        return mr.registeredAnimal(cri);
    }
}
