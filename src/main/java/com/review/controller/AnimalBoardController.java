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
    public String AnimalReviewList(AnimalReviewDTO reviewDTO, Model model){
        log.info("리뷰 게시판");

        List<AnimalReviewDTO> reviewList = service.ReviewList(reviewDTO);
        model.addAttribute("list", reviewList);
        return "/animal/board/RvfindAll";
    }

    @GetMapping("/animal/review")
    public String MedicalReview(){
        return "/animal/board/evaluation";
    }

    @PostMapping("/animal/review")
    public String MedicalReview(AnimalReviewDTO reviewDTO){
        service.ReviewWrite(reviewDTO);
        return "redirect:/animal/reviewList";
    }
    
    @GetMapping("/animal/viewDetails")
    public String ViewDetails(AnimalReviewDTO reviewDTO, Model model){
        
        model.addAttribute("animal", service.information(reviewDTO.getReviewNum()));

        return "/animal/board/viewDetails";
    }

    @GetMapping("/animal/correction")
    public String CorrectionBefore(AnimalReviewDTO reviewDTO, Model model){

        model.addAttribute("animal", service.information(reviewDTO.getReviewNum()));
        return "/animal/board/correction";
    }

    @PostMapping("/animal/correction")
    public String CorrectionAfter(AnimalReviewDTO reviewDTO, Model model){
        service.Correction(reviewDTO);
        model.addAttribute("animal",service.information(reviewDTO.getReviewNum()));
        return "/animal/board/viewDetails";

    }

    @GetMapping("/animal/DeletePost")
    public String DeletePost(@RequestParam("reviewNum") int reviewNum){
        service.DeleteUsingNum(reviewNum);

        return "redirect:/animal/reviewList";

    }
}
