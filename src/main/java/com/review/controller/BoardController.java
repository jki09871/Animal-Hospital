package com.review.controller;

import com.review.dto.BoardDTO;
import com.review.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/board/*")
public class BoardController {

    @Setter(onMethod_ = @Autowired)
    private BoardService service;

    @GetMapping("/save")
    public String BoardSave(){
        return "/board/save";
    }

    @PostMapping("/save")
    public String BoarSavePost(BoardDTO boardDTO){
        service.save(boardDTO);

        return "redirect:/board/list";
    }

    @GetMapping("/list")
    public String BoardList(BoardDTO boardDTO, Model model){

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
