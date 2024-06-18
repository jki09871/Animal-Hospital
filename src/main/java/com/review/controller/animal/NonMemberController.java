package com.review.controller.animal;

import com.review.dto.animal.InquiryBoardDTO;
import com.review.dto.animal.NonMembersDTO;
import com.review.service.animal.MedicalInquiryService;
import com.review.service.animal.NonMemberService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Log4j
@Controller
@RequiredArgsConstructor
public class NonMemberController {

    @Setter(onMethod_ = @Autowired)
    private NonMemberService nms;

    @Setter(onMethod_ = @Autowired)
    private MedicalInquiryService mis;

    @PostMapping("/nonMembers/inquiry")
    public String nonMembersInquiry(NonMembersDTO memberDTO, InquiryBoardDTO boardDTO){
        int membersDTO = nms.registeredMemberCount(memberDTO);
        if (membersDTO == 0) {
            nms.nonMembersRegister(memberDTO);
        }
        mis.register(boardDTO);
        return "forward:/";
    }
}
