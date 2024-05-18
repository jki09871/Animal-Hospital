package com.review.controller.animal;

import com.review.dto.animal.InquiryBoardDTO;
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

@Log4j
@Controller
@AllArgsConstructor
public class InquiryBoardController {

    @Setter(onMethod_ = @Autowired)
    private MedicalInquiryService is;


    @RequestMapping("/pet/inquiry/list")
    public String list(Model model){
        log.info("list.....");
        model.addAttribute("list", is.getList());
        return "/animal/inquiry/list";

    }
    @GetMapping("/pet/inquiry/register")
    public String GetRegister(){
        log.info("Get Register........");
        return "/animal/inquiry/register";
    }

    //글 쓰기
    @PostMapping("/pet/inquiry/register")
    public String register(InquiryBoardDTO board, RedirectAttributes rttr){
        /** @Conteroller 어노테이션이 붙고, 컴포넌트스캔에 패키지가 지정되어 있다면
            매개변수 인자들은 스프링이 자동으로 생성 할당 함.
            <context:component-scan base-package="com.review.controller" />
         **/
        log.info("register: " + board);
        is.register(board);
        rttr.addFlashAttribute("result", board.getInquiryNum());
        // 리다이렉트 시키면서 1회용 값을 전달.
        return "redirect:/pet/inquiry/list";
    }


    // 글 읽기
    @GetMapping("/pet/inquiry/get")
    public String get(@RequestParam("inquiryNum") Long inquiryNum, Model model){
        log.info("/get.....");
        model.addAttribute("board", is.get(inquiryNum));
        return "/animal/inquiry/get";
    }
    @GetMapping("/pet/inquiry/modify")
    public String getModify(@RequestParam("inquiryNum") Long inquiryNum, Model model){
        log.info("/get.....");
        model.addAttribute("board", is.get(inquiryNum));
        return "/animal/inquiry/modify";
    }

    // 글 수정
    @PostMapping("/pet/inquiry/modify")
    public String modify(InquiryBoardDTO board, RedirectAttributes rttr){
        log.info("modify" + board);
        if (is.modify(board)){
            is.get(board.getInquiryNum());
            Long inquiryNum = board.getInquiryNum();
            rttr.addAttribute("inquiryNum",inquiryNum);
        }
        /** 수정이 성공하면 success 메세지가 포함되어 이동. 실패해도 메세지 뺴고 이동. **/
        return "redirect:/pet/inquiry/get";
    }

    // 글 삭제
    @PostMapping("/pet/inquiry/remove")
    public String remove(@RequestParam("inquiryNum") Long inquiryNum, RedirectAttributes rttr) {
        log.info("remove" + inquiryNum);
        if (is.remove(inquiryNum)) {
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/pet/inquiry/list";
    }
}
