package com.review.controller.animal;

import com.review.dto.animal.AnimalInquiryCommentDTO;
import com.review.service.animal.AnimalInquiryCommentService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalInquiryCommentController {

    @Setter(onMethod_ = @Autowired)
    private AnimalInquiryCommentService ics;

    @PostMapping("/inquiry/comment/save")
    public @ResponseBody List<AnimalInquiryCommentDTO> commentSave(@ModelAttribute AnimalInquiryCommentDTO commentDTO, Model model) {
        System.out.println("commentDTO = " + commentDTO);
        ics.commentSave(commentDTO);
        Map<String, Object> num = new HashMap<>();
        num.put("inquiry_num", commentDTO.getInquiry_num());
        List<AnimalInquiryCommentDTO> commentList = ics.commentFindAll(num);
        return commentList;
    }

    @RequestMapping("/inquiry/comment/delete")
    @ResponseBody
    public String commentDel(@RequestParam("id") int id){
        System.out.println("id = " + id);
        ics.commentDelete(id);
        return "success";
    }

    @RequestMapping("/inquiry/comment/update")
    @ResponseBody
    public String commentUpdate(AnimalInquiryCommentDTO commentDTO){
        ics.commentUpdate(commentDTO);
        System.out.println("comment_Content = " + commentDTO);
        return "success";
    }
}

