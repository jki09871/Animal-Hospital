package com.review.controller;

import com.review.dto.BoardDTO;
import com.review.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/board/*")
public class BoardController {

    @Setter(onMethod_ = @Autowired)
    private BoardService service;

    @GetMapping("/save")
    public String BoardSave(Model model, HttpSession session){

        model.addAttribute("kakaosessionId", session.getAttribute("kakaosessionId"));
        model.addAttribute("naversessionId", session.getAttribute("naversessionId"));
        model.addAttribute("loginEmail", session.getAttribute("loginEmail"));

        return "/board/save";
    }


    @PostMapping("/save")
    public String BoarSavePost(BoardDTO boardDTO){
        service.save(boardDTO);
        System.out.println("boardDTO = " + boardDTO);

        return "redirect:/board/list";
    }

    @GetMapping("/list")
    public String BoardList(BoardDTO boardDTO, HttpSession session, Model model){

       model.addAttribute("loginEmail", session.getAttribute("loginEmail"));
       model.addAttribute("kakaosessionId", session.getAttribute("kakaosessionId"));
       model.addAttribute("naversessionId", session.getAttribute("naversessionId"));




        List<BoardDTO> boarsList = service.list(boardDTO);
        model.addAttribute("boardList", boarsList);
        return "/board/list";
    }

    @GetMapping("/read")
    public String BoardRead(@RequestParam("bno") int bno, BoardDTO boardDTO, Model model){
        service.hits(bno);
        model.addAttribute("board", service.read(bno));
        return "/board/read";
    }

    @GetMapping("/delete")
    public String BoardDelete(@RequestParam("bno") int bno) {
        service.delete(bno);
        return "forward:/board/list";
    }

    @GetMapping("/update")
    public String BoardUpdateGet(BoardDTO boardDTO, Model model){
        model.addAttribute("board", service.read(boardDTO.getBno()));
        return "/board/update";
    }

    @PostMapping("/update")
    public String BoardUpdatePost(@ModelAttribute BoardDTO boardDTO, Model model){
        service.update(boardDTO);
        model.addAttribute("board",service.read(boardDTO.getBno()));
        return "/board/read";
    }
}
