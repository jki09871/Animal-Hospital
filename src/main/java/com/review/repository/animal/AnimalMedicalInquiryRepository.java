package com.review.repository.animal;

import com.review.dto.animal.AnimalInquiryBoardDTO;
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
public class AnimalMedicalInquiryRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;


    public List<Map<String,Object>> getList(){
        return sql.selectList("inquiry.getList");
    }

    public int insert(AnimalInquiryBoardDTO board){
       return sql.insert("inquiry.insert", board);
        
    }

    public Map<String, Object> read(Map<String, Object> num){
        return sql.selectOne("inquiry.read", num);
        
    }

    public int delete(long inquiry_Num){
        return sql.delete("inquiry.delete", inquiry_Num);
    }

    public int update(AnimalInquiryBoardDTO board){
        return sql.update("inquiry.update", board);
    }

    public Map<String, Object> privateInquiryRead(Map<String, Object> paramMap) {
        return sql.selectOne("inquiry.read", paramMap);
    }

    public List<AnimalInquiryBoardDTO> inquiryIWrote(String ownerId) {
        return sql.selectList("inquiry.inquiryIWrote", ownerId);
    }
}
