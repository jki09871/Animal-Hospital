package com.review.controller;

import com.review.dto.AnimalDTO;
import com.review.service.AnimalService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalController {
    @Setter(onMethod_ = @Autowired)
    private AnimalService as;

    /**************************  회원 가입  ********************************/
    @GetMapping("/animal/signup")
    public String SignupScreenGet(){
        log.info("## 회원가입 화면 ##");
        return "/animal/ownerSignupScreen";
    }
    @PostMapping("/animal/signup")
    public String PostSignupScreen(AnimalDTO animalDTO){
        System.out.println("## animalDTO = " + animalDTO);
        int SignupResult = as.PostSignupScreen(animalDTO);

        if (SignupResult > 0){
            return "/animal/login";
        }else {
         return "/animal/ownerSignupScreen";
        }
    }
    /************************************************************************************************************/

    /***********************  로그인  & 로그아웃 ***************************/
    @GetMapping("/animal/login")
    public String MemberLogin(){
        log.info(" 로그인 화면 ");
        return "/animal/login";
    }
    
    @PostMapping("/animal/login")
    public String MemberLogin(AnimalDTO animalDTO, HttpServletRequest request){
        HttpSession session = request.getSession();

        animalDTO = as.UserVerification(animalDTO);
        if (animalDTO != null) {
            session.setAttribute("loginId", animalDTO.getOwnerId());
            log.info("로그인 성공");
            return "redirect:/board/list";
        } else {
            log.info("로그인 실패");
            return "/animal/login";
        }
    }

    /** 로그아웃 **/
    @RequestMapping("/animal/logout")
    public String MemberLogout(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if(session != null){
            session.invalidate();
        }
        return "redirect:/";
    }
    /************************************************************************************************************/

    /*********************  이메일 & 아이디 체크  **************************/

    @RequestMapping("/animal/EmailCheck")
    @ResponseBody
    public boolean EmailValidCheck(@RequestParam(required = false) String email,
                                   @RequestParam(required = false) String IdCheck){

        /** 아이디와 이메일을 맵에 넣어서 유효성체크 **/
        Map<String, Object> valid = new HashMap<>();
        valid.put("email", email);
        valid.put("IdCheck", IdCheck);

        boolean EmailCheckReturn = as.JoinEmailCheck(valid);

        return EmailCheckReturn;
    }
    /************************************************************************************************************/


}