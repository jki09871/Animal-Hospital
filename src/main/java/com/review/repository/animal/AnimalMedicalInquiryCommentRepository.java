package com.review.repository.animal;

import com.review.dto.animal.AnimalInquiryCommentDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Log4j
@RequiredArgsConstructor
public class AnimalMedicalInquiryCommentRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;

    public void commentSave(AnimalInquiryCommentDTO commentDTO) {
        sql.insert("comment.save", commentDTO);
    }

    public List<AnimalInquiryCommentDTO> commentFindAll(Map<String, Object> inquiry_num) {
        return sql.selectList("comment.findAll", inquiry_num);
    }

    public void commentDelete(int id) {
        sql.delete("comment.delete", id);
    }

    public void commentUpdate(AnimalInquiryCommentDTO commentDTO) {
        sql.update("comment.update", commentDTO);
    }
}
