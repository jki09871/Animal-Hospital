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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
        List<InquiryCommentDTO> commentList = ics.commentFindAll(commentDTO.getBoardId());
        return commentList;
    }

}

