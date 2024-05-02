package com.review.controller;

import com.review.dto.AnimalMemberDTO;
import com.review.service.AnimalService;
import com.review.util.Pbkdf2PasswordEncoderUtil;
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
public class AnimalMemberController {
    @Setter(onMethod_ = @Autowired)
    private AnimalService as;

    /**************************  회원 가입  ********************************/
    @GetMapping("/animal/signup")
    public String signupScreenGet(){
        log.info("## 회원가입 화면 ##");
        return "/animal/ownerSignupScreen";
    }
    @PostMapping("/animal/signup")
    public String postSignupScreen(AnimalMemberDTO animalDTO){

        Pbkdf2PasswordEncoderUtil pbkdf2PasswordEncoderUtil = new Pbkdf2PasswordEncoderUtil();

        animalDTO.setPassword(pbkdf2PasswordEncoderUtil.pbkdf2PasswordEncoder.encode(animalDTO.getPassword()));
        int SignupResult = as.postSignupScreen(animalDTO);
        if (SignupResult > 0){
            return "/animal/login";
        }else {
         return "/animal/ownerSignupScreen";
        }
    }
    /************************************************************************************************************/

    /***********************  로그인  & 로그아웃 ***************************/
    @GetMapping("/animal/login")
    public String memberLogin(){
        log.info(" 로그인 화면 ");
        return "/animal/login";
    }
    
    @PostMapping("/animal/login")
    public String memberLogin(AnimalMemberDTO animalDTO, HttpServletRequest request){

        AnimalMemberDTO dbDto = as.userVerification(animalDTO);
        boolean loginResult = false;
        if (dbDto != null){
            Pbkdf2PasswordEncoderUtil pbkdf2PasswordEncoderUtil = new Pbkdf2PasswordEncoderUtil();
            if (pbkdf2PasswordEncoderUtil.pbkdf2PasswordEncoder
                    .matches(animalDTO.getPassword(), dbDto.getPassword())){
                loginResult = true;
            }
        }

        HttpSession session = request.getSession();
        if (animalDTO != null) {
            session.setAttribute("loginId", animalDTO.getOwnerId());
            log.info("로그인 성공");
            return "redirect:/animal/reviewList";
        } else {
            log.info("로그인 실패");
            return "/animal/login";
        }
    }

    /** 로그아웃 **/
    @RequestMapping("/animal/logout")
    public String memberLogout(HttpServletRequest request){
        HttpSession session = request.getSession(false);
        if(session != null){
            session.invalidate();
        }
        return "redirect:/";
    }
    /************************************************************************************************************/

    /*********************  이메일 & 아이디 체크  **************************/

    @RequestMapping("/animal/emailCheck")
    @ResponseBody
    public boolean emailValidCheck(@RequestParam(required = false) String email,
                                   @RequestParam(required = false) String ownerId){
        System.out.println("ownerId = " + ownerId);

        /** 아이디와 이메일을 맵에 넣어서 유효성체크 **/
        Map<String, Object> valid = new HashMap<>();
        valid.put("email", email);
        valid.put("ownerId", ownerId);

        boolean emailCheckReturn = as.joinEmailCheck(valid);

        return emailCheckReturn;
    }
    /************************************************************************************************************/


}