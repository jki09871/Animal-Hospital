package com.review.controller;

import com.review.dto.MemberDTO;
import com.review.naver.NaverLoginBO;
import com.review.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class MemberController {


    @Setter(onMethod_ = @Autowired)
    private final MemberService memberService;

    @Setter(onMethod_ = @Autowired)
    private final NaverLoginBO naverLoginBO;

    @RequestMapping("/member/jusoPopup")
    public String jusoPopup() {

        return "/member/jusoPopup";

    }
    @GetMapping("/member/joinmembership")
    public String JoinMembership() throws Exception{

        return "/member/joinmembership";
    }

    @PostMapping("/member/joinmembership")
    public String JoinMembership(@ModelAttribute MemberDTO memberDTO){
        int saveResult = memberService.joinMembership(memberDTO);
        if (saveResult > 0){
            return "/member/login";
        }else {
            return "/member/joinmembership";

        }
    }

    @GetMapping("/member/login")
    public String logInScreen(HttpSession session, Model model) {

        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

        System.out.println("naverAuthUrl = " + naverAuthUrl);

        //네이버
        model.addAttribute("url", naverAuthUrl);


        return "member/login";
    }

    @PostMapping("/member/login")
    public String LoginScreen(@ModelAttribute MemberDTO memberDTO, HttpServletRequest request){
        memberDTO = memberService.userConfirmation(memberDTO);



        HttpSession session = request.getSession();
        boolean loginResult = false;
        if (memberDTO != null){
//            session.setAttribute("loginEmail", memberDTO.getMemberEmail());
            session.setAttribute("loginEmail", memberDTO);
            return "redirect:/board/list";
        } else {
            return "/member/login";
        }
    }

    @GetMapping("/member/email")
    @ResponseBody
    public boolean emailValidation(String email){

        System.out.println("email = " + email);

        boolean EmailCheck = memberService.EmailJoinCheck(email);

        return EmailCheck ;
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {

        //세션을 삭제
        HttpSession session = request.getSession(false);
        // Session이 null이 아니라는건 기존에 세션이 존재했었다는 뜻이므로
        // 세션이 null이 아니라면 session.invalidate()로 세션 삭제해주기.


        if(session != null) {
            session.invalidate();
        }
        return "/member/login";
    }

}
