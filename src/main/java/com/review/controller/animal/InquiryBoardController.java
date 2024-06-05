package com.review.controller.animal;

import com.review.dto.animal.InquiryBoardDTO;
import com.review.dto.animal.InquiryCommentDTO;
import com.review.service.animal.InquiryCommentService;
import com.review.service.animal.MedicalInquiryService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Log4j
@Controller
@AllArgsConstructor
public class InquiryBoardController {


    private final MedicalInquiryService is;
    private final InquiryCommentService ics;

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
    public String register(InquiryBoardDTO board, RedirectAttributes rttr){

        log.info("register: " + board);
        is.register(board);
        rttr.addFlashAttribute("result", board.getInquiry_Num());
        // 리다이렉트 시키면서 1회용 값을 전달.
        return "redirect:/pet/inquiry/list";
    }


    // 글 읽기
    @GetMapping("/pet/inquiry/get")
    public String get(@RequestParam("inquiry_Num") Long inquiry_Num, Model model){
        log.info("/get.....");
        Map<String, Object> num = new HashMap<>();
        num.put("inquiry_num", inquiry_Num);
        model.addAttribute("board", is.get(inquiry_Num));
        List<InquiryCommentDTO> commentList = ics.commentFindAll(num);
        model.addAttribute("commentList", commentList);
        return "/animal/inquiry/get";
    }

    // 글 수정
    @GetMapping("/pet/inquiry/modify")
    public String getModify(@RequestParam("inquiry_Num") Long inquiry_Num, Model model){
        log.info("/get.....");
        model.addAttribute("board", is.get(inquiry_Num));
        return "/animal/inquiry/modify";
    }

    // 글 수정
    @PostMapping("/pet/inquiry/modify")
    public String modify(InquiryBoardDTO board, RedirectAttributes rttr){
        log.info("modify" + board);
        if (is.modify(board)){
            is.get(board.getInquiry_Num());
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
}
