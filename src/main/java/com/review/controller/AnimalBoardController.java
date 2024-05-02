package com.review.controller;

import com.review.dto.AnimalReviewDTO;
import com.review.service.MedicalReviewService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalBoardController {

    @Setter(onMethod_ = @Autowired)
    private MedicalReviewService service;

    @RequestMapping("/animal/reviewList")
    public String animalReviewList(AnimalReviewDTO reviewDTO, Model model){
        log.info("리뷰 게시판");

        List<AnimalReviewDTO> reviewList = service.reviewList(reviewDTO);
        model.addAttribute("list", reviewList);
        return "/animal/board/rvfindAll";
    }

    @GetMapping("/animal/review")
    public String medicalReview(){
        return "/animal/board/evaluation";
    }

    @PostMapping("/animal/review")
    public String medicalReview(AnimalReviewDTO reviewDTO){
        service.reviewWrite(reviewDTO);
        System.out.println("reviewDTO = " + reviewDTO);
        return "redirect:/animal/reviewList";
    }
    
    @GetMapping("/animal/viewDetails")
    public String viewDetails(AnimalReviewDTO reviewDTO, Model model){
        AnimalReviewDTO information = service.information(reviewDTO.getReviewNum());
        System.out.println("information = " + information);
        model.addAttribute("animal", information);

        return "/animal/board/viewDetails";
    }

    @GetMapping("/animal/correction")
    public String correctionBefore(AnimalReviewDTO reviewDTO, Model model){

        model.addAttribute("animal", service.information(reviewDTO.getReviewNum()));
        return "/animal/board/correction";
    }

    @PostMapping("/animal/correction")
    public String correctionAfter(AnimalReviewDTO reviewDTO, Model model){
        service.correction(reviewDTO);
        model.addAttribute("animal",service.information(reviewDTO.getReviewNum()));
        return "/animal/board/viewDetails";

    }

    @GetMapping("/animal/deletePost")
    public String deletePost(@RequestParam("reviewNum") int reviewNum){
        service.deleteUsingNum(reviewNum);

        return "redirect:/animal/reviewList";

    }
}
