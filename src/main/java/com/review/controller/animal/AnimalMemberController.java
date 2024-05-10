package com.review.controller.animal;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.service.animal.OwnerService;
import com.review.util.Pbkdf2PasswordEncoderUtil;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    private OwnerService as;

    /************************************************  회원 가입  ************************************************/
    @GetMapping("/animal/signup")
    public String signupScreenGet(){
        log.info("## 회원가입 화면 ##");
        return "/animal/owner/ownerSignup";
    }
    @PostMapping("/animal/signup")
    public String postSignupScreen(AnimalMemberDTO animalDTO){

        Pbkdf2PasswordEncoderUtil pbkdf2PasswordEncoderUtil = new Pbkdf2PasswordEncoderUtil();

        animalDTO.setPassword(pbkdf2PasswordEncoderUtil.pbkdf2PasswordEncoder.encode(animalDTO.getPassword()));
        int SignupResult = as.postSignupScreen(animalDTO);
        if (SignupResult > 0){
            return "/animal/owner/login";
        }else {
         return "/animal/owner/ownerSignup";
        }
    }
    /************************************************************************************************************/

    /*******************************************  로그인  & 로그아웃 **********************************************/
    @GetMapping("/animal/login")
    public String memberLogin(){
        log.info(" 로그인 화면 ");
        return "/animal/owner/login";
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
        if (loginResult) {
            session.setAttribute("loginId", animalDTO.getOwner_Id());
            log.info("로그인 성공");
            return "redirect:/animal/reviewList";
        } else {
            log.info("로그인 실패");
            return "/animal/owner/login";
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

    /*******************************************  이메일 & 아이디 체크  ********************************************/

    @RequestMapping("/animal/emailCheck")
    @ResponseBody
    public boolean emailValidCheck(@RequestParam(required = false) String email,
                                   @RequestParam(required = false) String ownerId){

        /** 아이디와 이메일을 맵에 넣어서 유효성체크 **/
        Map<String, Object> valid = new HashMap<>();
        valid.put("email", email);
        valid.put("ownerId", ownerId);

        boolean emailCheckReturn = as.joinEmailCheck(valid);

        return emailCheckReturn;
    }
    /************************************************************************************************************/

    /******************************************  사용자 정보 보기  ************************************************/
    @GetMapping("/animal/myInfo")
    public String myInformation(Model model, HttpServletRequest request){

        HttpSession session = request.getSession();
        Object ownerId = session.getAttribute("loginId");

        model.addAttribute("animal",as.myInformation(ownerId));
        return "/animal/owner/myInfo";
    }
    /************************************************************************************************************/

    /******************************************  사용자 정보 수정  ************************************************/
    @GetMapping("/animal/editInfo")
    public String editInfo(AnimalMemberDTO animalDTO, Model model, HttpServletRequest request){

        HttpSession session = request.getSession();
        Object ownerId = session.getAttribute("loginId");
        model.addAttribute("animal",as.myInformation(ownerId));

        return "/animal/owner/editInfo";
    }

    @PostMapping("/animal/editInfo")
    public String editInfo(AnimalMemberDTO animalDTO, HttpServletRequest request){

        as.editInfo(animalDTO);
        as.myInformation(animalDTO.getOwner_Id());

        return "/animal/owner/myInfo";
    }
    /**********************************************************************************************************/
}