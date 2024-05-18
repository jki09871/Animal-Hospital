package com.review.repository.animal;

import com.review.dto.animal.InquiryBoardDTO;
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
public class MedicalInquiryRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;


    public List<InquiryBoardDTO> getList(){
        return sql.selectList("inquiry.getList");
    }

    public int insert(InquiryBoardDTO board){
       return sql.insert("inquiry.insert", board);
        
    }

    public InquiryBoardDTO read(long inquiryNum){
        return sql.selectOne("inquiry.read", inquiryNum);
        
    }

    public int delete(long inquiryNum){
        return sql.delete("inquiry.delete", inquiryNum);
    }

    public int update(InquiryBoardDTO board){
        return sql.update("inquiry.update", board);
    }
}
