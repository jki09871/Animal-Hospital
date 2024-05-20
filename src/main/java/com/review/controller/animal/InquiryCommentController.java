package com.review.controller.animal;

import com.review.dto.animal.InquiryCommentDTO;
import com.review.service.animal.InquiryCommentService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Log4j
@Controller
@RequiredArgsConstructor
public class InquiryCommentController {

    @Setter(onMethod_ = @Autowired)
    private InquiryCommentService ics;

    @PostMapping("/inquiry/comment/save")
    public @ResponseBody List<InquiryCommentDTO> commentSave(@ModelAttribute InquiryCommentDTO commentDTO, Model model) {
        System.out.println("commentDTO = " + commentDTO);
        ics.commentSave(commentDTO);
        List<InquiryCommentDTO> commentList = ics.commentFindAll(commentDTO.getInquiry_num());
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
    public String commentUpdate(InquiryCommentDTO commentDTO){
        ics.commentUpdate(commentDTO);
        System.out.println("comment_Content = " + commentDTO);
        return "success";
    }
}

