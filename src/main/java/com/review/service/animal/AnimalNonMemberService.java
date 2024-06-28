package com.review.service.animal;

import com.review.dto.animal.AnimalNonMembersDTO;
import com.review.repository.animal.AnimalNonMemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
@RequiredArgsConstructor
public class AnimalNonMemberService {

    @Setter(onMethod_ = @Autowired)
    private AnimalNonMemberRepository nmr;

    public void nonMembersRegister(AnimalNonMembersDTO memberDTO) {
        nmr.nonMembersRegister(memberDTO);
    }

    public int registeredMemberCount(AnimalNonMembersDTO memberDTO) {
        return nmr.registeredMemberCount(memberDTO);
    }
}
