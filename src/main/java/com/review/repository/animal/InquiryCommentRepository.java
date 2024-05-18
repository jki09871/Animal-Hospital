package com.review.repository.animal;

import com.review.dto.animal.InquiryCommentDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Log4j
@RequiredArgsConstructor
public class InquiryCommentRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;

    public void commentSave(InquiryCommentDTO commentDTO) {
        sql.insert("comment.save", commentDTO);
    }

    public List<InquiryCommentDTO> commentFindAll(int boardId) {
        return sql.selectList("comment.findAll", boardId);
    }
}
