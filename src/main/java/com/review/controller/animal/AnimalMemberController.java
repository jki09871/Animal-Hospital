package com.review.controller.animal;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.service.animal.MedicalReviewService;
import com.review.service.animal.OwnerService;
import com.review.util.Pbkdf2PasswordEncoderUtil;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalMemberController {

    @Setter(onMethod_ = @Autowired)
    private JavaMailSender mailSender;
    @Setter(onMethod_ = @Autowired)
    private OwnerService os;

    @Setter(onMethod_ = @Autowired)
    MedicalReviewService mrs;

    /************************************************  회원 가입  ************************************************/
    @GetMapping("/animal/signup")
    public String signupScreenGet() {
        log.info("## 회원가입 화면 ##");
        return "/animal/owner/ownerSignup";
    }

    @PostMapping("/animal/signup")
    public String postSignupScreen(AnimalMemberDTO animalDTO) {

        try {
            MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            messageHelper.setFrom("ghdwjdrl1234@gmail.com");

            messageHelper.setTo(animalDTO.getEmail()); /** 받을 이메일 */
            messageHelper.setSubject("안녕하세요! 동물 입양센터입니다."); /** 이메일 제목 */
            messageHelper.setText("이메일 :" + animalDTO.getEmail() + "아이디 :" + animalDTO.getOwner_Id() +
                    "핸드폰 번호 :" + animalDTO.getPhoneNumber()); /** 내용*/
//            FileSystemResource fileSystemResource = new FileSystemResource(new File("C:\\js\\api\\123.html"));
//            messageHelper.addAttachment("html.html", fileSystemResource);

//            FileSystemResource file = new FileSystemResource(new File("C:\\mp\\file\\03b3eedcc5aa4f15b87bf65121495816.png"));
//            messageHelper.addInline("그냥 사진.png", file);

            mailSender.send(mimeMessage);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }


        Pbkdf2PasswordEncoderUtil pbkdf2PasswordEncoderUtil = new Pbkdf2PasswordEncoderUtil();

        animalDTO.setPassword(pbkdf2PasswordEncoderUtil.pbkdf2PasswordEncoder.encode(animalDTO.getPassword()));
        int SignupResult = os.postSignupScreen(animalDTO);
        if (SignupResult > 0) {
            return "/animal/owner/login";
        } else {
            return "/animal/owner/ownerSignup";
        }
    }
    /************************************************************************************************************/

    /*******************************************  로그인  & 로그아웃 **********************************************/
    @GetMapping("/animal/login")
    public String memberLogin() {
        log.info(" 로그인 화면 ");
        return "/animal/owner/login";
    }

    @PostMapping("/animal/login")
    public String memberLogin(AnimalMemberDTO animalDTO, HttpServletRequest request,
                              HttpServletResponse response, String toURL, boolean rememberId) throws Exception {


        AnimalMemberDTO dbDto = os.userVerification(animalDTO);
        boolean loginResult = false;
        if (dbDto != null) {
            Pbkdf2PasswordEncoderUtil pbkdf2PasswordEncoderUtil = new Pbkdf2PasswordEncoderUtil();
            if (pbkdf2PasswordEncoderUtil.pbkdf2PasswordEncoder
                    .matches(animalDTO.getPassword(), dbDto.getPassword())) {
                loginResult = true;

                // 실패 카운트 0 초기화

            }

        }/*else{


            //
            *//* 로그인 실패 카운트 --
            5보다 작은지 체크
            * update
            *  fail_cnt = fail_cnt + 1
            *
             5보다 크거가 같으면
             비밀번호 5회 이상 틀려 아이디가 잠겼습니다. 관리자에게 문의해주시기 바랍니다.
             관리자 - 회원 목록 - 비밀번호 초기화 -> 랜덤으로 메일로 발송 + 비밀번호 만료일 3개월 전으로 초기화

             *//*

        }*/

        /* 로그인 실패 카운트 --  */

        if (rememberId) {
            // 1. 쿠키에 아이디 저장
            Cookie cookie = new Cookie("owner_Id", dbDto.getOwner_Id());
            // 2. 응답에 저장
            response.addCookie(cookie);
        } else {
            // 1. 쿠키 삭제
            Cookie cookie = new Cookie("owner_Id", dbDto.getOwner_Id());
            // 2. 쿠키 삭제
            cookie.setMaxAge(0);
            // 3. 응답에 저장
            response.addCookie(cookie);
        }

        HttpSession session = request.getSession();
        if (loginResult) {

            if (request.getParameter("useCookie") != null) {

                Cookie loginCookie = new Cookie("loginCookie", session.getId());
                loginCookie.setPath("/");
                loginCookie.setMaxAge(60 * 60 * 24 * 7);
                response.addCookie(loginCookie);

                int amount = 60 * 60 * 24 * 7;
                Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount)); //로그인 유지 기간 설정
                os.keepLogin(animalDTO.getOwner_Id(), session.getId(), sessionLimit);
            }
            session.setAttribute("loginId", dbDto);
            log.info("로그인 성공");
            toURL = toURL == null || toURL.equals("") ? "/" : toURL;
            return "redirect:" + toURL;
        } else {
            log.info("로그인 실패");
            return "/animal/owner/login";
        }
    }

    /**
     * 로그아웃
     **/
    @RequestMapping("/animal/logout")
    public String memberLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        Object object = session.getAttribute("loginId");
        if (object != null) {
            AnimalMemberDTO memberDTO = (AnimalMemberDTO) object;
            session.removeAttribute("loginId");
            session.invalidate();
            Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
            if (loginCookie != null) {
                loginCookie.setPath("/");
                loginCookie.setMaxAge(0);
                response.addCookie(loginCookie);
                os.keepLogin(memberDTO.getOwner_Id(), "null", new Date());
            }

        }
        return "redirect:/";
    }
    /************************************************************************************************************/

    /*******************************************  이메일 & 아이디 체크  ********************************************/

    @RequestMapping("/animal/emailCheck")
    @ResponseBody
    public boolean emailValidCheck(@RequestParam(required = false) String email,
                                   @RequestParam(required = false) String ownerId) {

        /** 아이디와 이메일을 맵에 넣어서 유효성체크 **/
        Map<String, Object> valid = new HashMap<>();
        valid.put("email", email);
        valid.put("ownerId", ownerId);

        boolean emailCheckReturn = os.joinEmailCheck(valid);

        return emailCheckReturn;
    }
    /************************************************************************************************************/

    /******************************************  사용자 정보 보기  ************************************************/
    @GetMapping("/animal/myInfo")
    public String myInformation(Model model, HttpServletRequest request) {

        HttpSession session = request.getSession();
        Object ownerId = session.getAttribute("loginId");

        model.addAttribute("animal", os.myInformation(ownerId));
        return "/animal/owner/myInfo";
    }
    /************************************************************************************************************/

    /******************************************  사용자 정보 수정  ************************************************/
    @GetMapping("/animal/editInfo")
    public String editInfo(AnimalMemberDTO animalDTO, Model model, HttpServletRequest request) {

        HttpSession session = request.getSession();
        Object ownerId = session.getAttribute("loginId");
        model.addAttribute("animal", os.myInformation(ownerId));

        return "/animal/owner/editInfo";
    }

    @PostMapping("/animal/editInfo")
    public String editInfo(AnimalMemberDTO animalDTO, HttpServletRequest request) {

        os.editInfo(animalDTO);
        os.myInformation(animalDTO.getOwner_Id());

        return "redirect:/animal/myInfo";
    }


    /************************************  나의 활동 게시물  ********************************************/
    @GetMapping("/animal/postIWrote")
    public String postIWrote(@RequestParam("ownerId") String ownerId, Model model) {
        System.out.println("ownerId = " + ownerId);

        model.addAttribute("list", mrs.myWriting(ownerId));

        return "animal/owner/postIWrote";
    }
    /**********************************************************************************************************/

    /************************************  나의 활동 댓글  ********************************************/
    @GetMapping("/animal/commentIWrote")
    public String commentIWrote(@RequestParam("ownerId") String ownerId, Model model) {
        Map<String, Object> commentIWrote = new HashMap<>();
        commentIWrote.put("ownerId", ownerId);

        model.addAttribute("list", os.commentIWrote(commentIWrote));

        return "animal/owner/commentIWrote";
    }

    /**********************************************************************************************************/


    /************************************  아이디 찾기  ********************************************/
    @GetMapping("/animal/findId")
    public String findId() {
        log.info("아이디 찾기");
        return "/animal/owner/findId";
    }

    @PostMapping("/animal/findId")
    public @ResponseBody String findId(@RequestParam("email") String email, @RequestParam("phoneNumber") String phoneNumber) {
        Map<String, Object> findId = new HashMap<>();
        findId.put("email", email);
        findId.put("phone", phoneNumber);

        String id = os.findId(findId);
        if (id != null ) { // 문자열 "null"을 체크합니다.
            return id.replaceAll("(?<=.{3}).(?=.{2})", "*");
        } else {
            return null;
        }


    }
    /**********************************************************************************************************/
    /************************************  비밀번호 찾기  ********************************************/


    @GetMapping("/animal/findPw")
    public String findPw() {
        log.info("아이디 찾기");
        return "/animal/owner/findPw";
    }

    @PostMapping("/animal/findPw")
    public @ResponseBody String findPw(@RequestParam("email") String email, @RequestParam("owner_Id") String owner_Id) {
        Map<String, Object> findId = new HashMap<>();
        findId.put("email", email);
        findId.put("owner_Id", owner_Id);


        if (os.findPw(findId) != 0) {
            Pbkdf2PasswordEncoderUtil pbkdf2PasswordEncoderUtil = new Pbkdf2PasswordEncoderUtil();
            String randomPw = generateRandomString();
            String randomP2 = pbkdf2PasswordEncoderUtil.pbkdf2PasswordEncoder.encode(randomPw);
            findId.put("pwChange", randomP2);
            os.pwUpdate(findId);

            try {
                MimeMessage mimeMessage = mailSender.createMimeMessage();
                MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

                messageHelper.setFrom("ghdwjdrl1234@gmail.com");

                messageHelper.setTo(email); /** 받을 이메일 */
                messageHelper.setSubject("동물 입양센터입니다. 임시 비빌번호 발송되었습니다."); /** 이메일 제목 */

                String emailContent = "<html><body>" +
                        "<h3>안녕하세요, 동물 입양센터입니다.</h3>" +
                        "<p>임시 비밀번호가 발송되었습니다. 아래의 정보를 확인해 주세요:</p>" +
                        "<p><strong>임시 비밀번호:</strong> " + randomPw + "</p>" +
                        "<p>감사합니다.</p>" +
                        "</body></html>";

                messageHelper.setText(emailContent, true); // true indicates HTML

                mailSender.send(mimeMessage);
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

            return "success";
        } else {
            return null;
        }
    }

    // 랜덤 문자열 생성 메서드
    public String generateRandomString() {
        // 랜덤 문자열을 생성할 문자열 범위 지정
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        // 랜덤 문자열을 저장할 StringBuilder 객체 생성
        StringBuilder randomString = new StringBuilder();

        // SecureRandom 객체를 사용하여 보안성 있는 난수 생성
        SecureRandom secureRandom = new SecureRandom();

        // 문자열 길이가 8글자가 될 때까지 랜덤 문자열 생성
        for (int i = 0; i < 10; i++) {
            // 문자열 범위에서 랜덤한 인덱스 선택
            int randomIndex = secureRandom.nextInt(characters.length());
            // 선택된 인덱스의 문자를 랜덤 문자열에 추가
            randomString.append(characters.charAt(randomIndex));
        }

        // 생성된 랜덤 문자열 반환
        return randomString.toString();
    }

    @GetMapping("/animal/pwChange")
    public String pwChange(){
        return "animal/owner/pwChange";
    }

    @PostMapping("/animal/pwChange")
    public String pwChange(AnimalMemberDTO animalDTO, @RequestParam String pwChange,
                           @RequestParam String owner_Id, Model model, RedirectAttributes rttr, HttpServletRequest request) {
        AnimalMemberDTO dbDto = os.userVerification(animalDTO);
        Pbkdf2PasswordEncoderUtil pbkdf2PasswordEncoderUtil = new Pbkdf2PasswordEncoderUtil();
        boolean loginResult = false;
        if (dbDto != null) {
            if (pbkdf2PasswordEncoderUtil.pbkdf2PasswordEncoder.matches(animalDTO.getPassword(), dbDto.getPassword())) {
                loginResult = true;
            } else {
                model.addAttribute("error", "사용자를 찾을 수 없습니다. 다시 시도해 주세요.");
                return "/animal/owner/pwChange";
            }
        }

        Map<String, Object> pw = new HashMap<>();
        if (loginResult) {
            animalDTO.setPassword(pbkdf2PasswordEncoderUtil.pbkdf2PasswordEncoder.encode(pwChange));
            HttpSession session = request.getSession();

            os.pwChange(animalDTO);
            AnimalMemberDTO animalMemberDTO = os.userVerification(animalDTO);
            session.setAttribute("loginId", animalMemberDTO);
            rttr.addAttribute("success", "비밀번호가 변경되었습니다.");
            return "redirect:/";
        }
        return null;
    }
    @GetMapping("/animal/pwChangeNo")
    @ResponseBody
    public String pwChangeNo(AnimalMemberDTO memberDTO, HttpServletRequest request){
        HttpSession session = request.getSession();
        os.pwChange(memberDTO);
        AnimalMemberDTO animalMemberDTO = os.userVerification(memberDTO);
        session.setAttribute("loginId", animalMemberDTO);
        return "성공";
    }
}