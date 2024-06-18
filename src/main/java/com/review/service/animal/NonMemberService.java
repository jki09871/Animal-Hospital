package com.review.service.animal;

import com.review.dto.animal.NonMembersDTO;
import com.review.repository.animal.NonMemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Log4j
@Service
@RequiredArgsConstructor
public class NonMemberService {

    @Setter(onMethod_ = @Autowired)
    private NonMemberRepository nmr;

    public void nonMembersRegister(NonMembersDTO memberDTO) {
        nmr.nonMembersRegister(memberDTO);
    }

    public int registeredMemberCount(NonMembersDTO memberDTO) {
        return nmr.registeredMemberCount(memberDTO);
    }
}
