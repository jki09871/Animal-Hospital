package com.review.controller.animal;

import com.review.dto.animal.AnimalInquiryBoardDTO;
import com.review.dto.animal.AnimalNonMembersDTO;
import com.review.service.animal.AnimalMedicalInquiryService;
import com.review.service.animal.AnimalNonMemberService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalNonMemberController {

    @Setter(onMethod_ = @Autowired)
    private AnimalNonMemberService nms;

    @Setter(onMethod_ = @Autowired)
    private AnimalMedicalInquiryService mis;

    @PostMapping("/nonMembers/inquiry")
    public String nonMembersInquiry(AnimalNonMembersDTO memberDTO, AnimalInquiryBoardDTO boardDTO){
        int membersDTO = nms.registeredMemberCount(memberDTO);
        if (membersDTO == 0) {
            nms.nonMembersRegister(memberDTO);
        }
        mis.register(boardDTO);
        return "forward:/";
    }
}
