package com.review.controller.animal;

import com.review.dto.animal.AnimalInquiryBoardDTO;
import com.review.dto.animal.AnimalInquiryCommentDTO;
import com.review.service.animal.AnimalInquiryCommentService;
import com.review.service.animal.AnimalMedicalInquiryService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Log4j
@Controller
@AllArgsConstructor
public class AnimalInquiryBoardController {


    private final AnimalMedicalInquiryService is;
    private final AnimalInquiryCommentService ics;


    @RequestMapping("/pet/inquiry/list")
    public String list(Model model){
        log.info("list.....");
        model.addAttribute("list", is.getList());
        return "/animal/inquiry/list";

    }
    @GetMapping("/pet/inquiry/register")
    public String GetRegister(HttpServletRequest request, String toURL, Model model){
        HttpSession session = request.getSession();
        String msg = "로그인 후 이용해주세요";
        if (session.getAttribute("loginId") == null) {
            model.addAttribute("msg", msg);
            return "redirect:/animal/login?toURL=" + request.getRequestURL();
        }
        log.info("Get Register........");
        return "/animal/inquiry/register";
    }

    //글 쓰기
    @PostMapping("/pet/inquiry/register")
    public String register(AnimalInquiryBoardDTO board, RedirectAttributes rttr){



        System.out.println("board@@@@@@@@@@@@@ = " + board);
        is.register(board);
        rttr.addFlashAttribute("result", board.getInquiry_Num());
        // 리다이렉트 시키면서 1회용 값을 전달.
        return "redirect:/pet/inquiry/list";
    }


    // 글 읽기
    @GetMapping("/pet/inquiry/get")
    public String get(@RequestParam("inquiry_Num") Long inquiry_Num, Model model){
        Map<String, Object> num = new HashMap<>();
        num.put("inquiry_num", inquiry_Num);

        model.addAttribute("board", is.get(num));

        List<AnimalInquiryCommentDTO> commentList = ics.commentFindAll(num);

        model.addAttribute("commentList", commentList);
        return "/animal/inquiry/get";
    }

    // 글 수정
    @GetMapping("/pet/inquiry/modify")
    public String getModify(@RequestParam("inquiry_Num") Long inquiry_Num, Model model){

        Map<String, Object> num = new HashMap<>();
        num.put("inquiry_num", inquiry_Num);

        Map<String, Object> inquiryRead = is.get(num);

        model.addAttribute("board",inquiryRead );
        return "/animal/inquiry/modify";
    }

    // 글 수정
    @PostMapping("/pet/inquiry/modify")
    public String modify(AnimalInquiryBoardDTO board, RedirectAttributes rttr){
        Map<String, Object> num = new HashMap<>();
        num.put("inquiry_num", board.getInquiry_Num());

        if (is.modify(board)){
            is.get(num);
            Long inquiry_Num = board.getInquiry_Num();
            rttr.addAttribute("inquiry_Num",inquiry_Num);
        }
        return "redirect:/pet/inquiry/get";
    }

    // 글 삭제
    @PostMapping("/pet/inquiry/remove")
    public String remove(@RequestParam("inquiry_Num") Long inquiry_Num, RedirectAttributes rttr) {
        log.info("remove" + inquiry_Num);
        if (is.remove(inquiry_Num)) {
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/pet/inquiry/list";
    }

    @GetMapping(value = "/inquiry/password/send", produces = "application/text; charset=utf8" )
    @ResponseBody
    public String privateInquiryRead(@RequestParam Map<String, Object> paramMap){
        System.out.println("paramMap = " + paramMap);
        Map<String, Object> privateInquiryCnt =  is.privateInquiryRead(paramMap);
        if (privateInquiryCnt != null) {
            return "성공";
        } else {
            return "비밀번호가 틀렸습니다.";
        }
    }
}
