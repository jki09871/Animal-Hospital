package com.review.service;

import com.review.dto.MemberDTO;
import com.review.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberService {

    @Setter(onMethod_ = @Autowired)
    private final MemberRepository memberRepository;

    public int joinMembership(MemberDTO memberDTO) {                         /** 회원가입 **/

        return memberRepository.joinMembership(memberDTO);
    }

    public boolean EmailJoinCheck(String Email) {                            /** 회원가입 이메일체크 **/
        int EmailCheck = memberRepository.EmailJoinCheck(Email);

        System.out.println("### EmailCheck :: " + EmailCheck);
        if (EmailCheck == 0){
            System.out.println("EmailCheck = " + "사용가능");
            return true;
        } else {
            System.out.println("EmailCheck = " + "이미있음");
            return false;
        }
    }

    public MemberDTO userConfirmation(MemberDTO memberDTO) {                 /** 로그인 **/
        return memberRepository.userConfirmation(memberDTO);
    }

}
