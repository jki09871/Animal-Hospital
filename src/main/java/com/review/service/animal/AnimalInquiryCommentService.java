package com.review.service.animal;

import com.review.dto.animal.AnimalInquiryCommentDTO;
import com.review.repository.animal.AnimalMedicalInquiryCommentRepository;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@Log4j
@AllArgsConstructor
public class AnimalInquiryCommentService {

    @Setter(onMethod_ = @Autowired)
    private AnimalMedicalInquiryCommentRepository icr;

    public void commentSave(AnimalInquiryCommentDTO commentDTO) {
        icr.commentSave(commentDTO);
    }

    public List<AnimalInquiryCommentDTO> commentFindAll(Map<String, Object> inquiry_num) {
       return icr.commentFindAll(inquiry_num);
    }

    public void commentDelete(int id) {
        icr.commentDelete(id);
    }

    public void commentUpdate(AnimalInquiryCommentDTO commentDTO) {
        icr.commentUpdate(commentDTO);
    }
}
