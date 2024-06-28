package com.review.service.animal;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.dto.animal.AnimalDTO;
import com.review.paging.PagingCriteria;
import com.review.repository.animal.AnimalSiteAdministratorRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j
public class AnimalSiteAdministratorService {

    @Setter(onMethod_ = @Autowired)
    private AnimalSiteAdministratorRepository mr;

    public List<AnimalMemberDTO> memberList() {
       return mr.memberList();

    }
    public AnimalMemberDTO memberData(AnimalMemberDTO memberDTO) {
        return mr.memberData(memberDTO);
    }

    public List<AnimalDTO> animalList(PagingCriteria cri) {
        return mr.petList(cri);
    }

    public AnimalDTO petData(AnimalDTO petDTO) {
        return mr.petData(petDTO);
    }

    public int postTotal(PagingCriteria cri) {
        return mr.registeredAnimal(cri);
    }
}
