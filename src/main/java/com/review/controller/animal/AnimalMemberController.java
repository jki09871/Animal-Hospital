package com.review.controller.animal;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.service.animal.OwnerService;
import com.review.util.Pbkdf2PasswordEncoderUtil;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalMemberController {

    @Setter(onMethod_ = @Autowired)
    private JavaMailSender mailSender;
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

        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            messageHelper.setFrom("ghdwjdrl1234@gmail.com");

            messageHelper.setTo(animalDTO.getEmail()); /** 받을 이메일 */
            messageHelper.setSubject("안녕하세요! 동물 입양센터입니다."); /** 이메일 제목 */
            messageHelper.setText("이메일 :" + animalDTO.getEmail() + "아이디 :" + animalDTO.getOwner_Id() +
                                    "핸드폰 번호 :" + animalDTO.getPhoneNumber()); /** 내용*/
            FileSystemResource fileSystemResource = new FileSystemResource(new File("C:\\js\\api\\123.html"));
            messageHelper.addAttachment("html.html", fileSystemResource);

            FileSystemResource file = new FileSystemResource(new File("C:\\mp\\file\\03b3eedcc5aa4f15b87bf65121495816.png"));
            messageHelper.addInline("그냥 사진.png", file);

            mailSender.send(mimeMessage);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }


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
            session.setAttribute("loginId", dbDto);
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

        return "redirect:/animal/myInfo";
    }
    /**********************************************************************************************************/


    //mailSend code

    @GetMapping("animal/owner/mail")
    public String mailSend(){
        return "/animal/owner/mailSender";
    }
    @PostMapping("/animal/owner/mail")
    public String mailSend(HttpServletRequest request, String name, String email, String phone, String message ){
        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            messageHelper.setFrom("ghdwjdrl1234@gmail.com");

            messageHelper.setTo("ghdwjdrl56@naver.com");
            messageHelper.setSubject("테스용 메시지 내 이름 :" + name + "입니다.");
            messageHelper.setText(message + "연락처는 " + phone + "이메일 주소는 " + email + "이다.");

            mailSender.send(mimeMessage);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

        return "redirect:/";
    }

}