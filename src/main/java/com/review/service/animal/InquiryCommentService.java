package com.review.service.animal;

import com.review.dto.animal.InquiryCommentDTO;
import com.review.repository.animal.InquiryCommentRepository;
import com.review.repository.animal.MedicalInquiryRepository;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
@AllArgsConstructor
public class InquiryCommentService {

    @Setter(onMethod_ = @Autowired)
    private InquiryCommentRepository icr;

    public void commentSave(InquiryCommentDTO commentDTO) {
        icr.commentSave(commentDTO);
    }

    public List<InquiryCommentDTO> commentFindAll(int inquiry_num) {
       return icr.commentFindAll(inquiry_num);
    }

    public void commentDelete(int id) {
        icr.commentDelete(id);
    }

    public void commentUpdate(InquiryCommentDTO commentDTO) {
        icr.commentUpdate(commentDTO);
    }
}
