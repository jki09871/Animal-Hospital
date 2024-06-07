package com.review.repository.animal;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.dto.animal.InquiryCommentDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@Log4j
@RequiredArgsConstructor
public class OwnerRepository {

    private final SqlSessionTemplate sql;


    public int postSignupScreen(AnimalMemberDTO animalDTO) {
       return sql.insert("animal.signup", animalDTO);
    }

    public AnimalMemberDTO userVerification(AnimalMemberDTO animalDTO) {
        return sql.selectOne("animal.login", animalDTO);
    }

    public int joinEmailCheck(Map<String, Object> valid) {

        return sql.selectOne("animal.emailCheck", valid);
    }


    public AnimalMemberDTO myInformation(Object ownerId) {
        return sql.selectOne("animal.myInfo", ownerId);
    }

    public void editInfo(AnimalMemberDTO animalDTO) {
        sql.update("animal.editInfo", animalDTO);
    }

    public List<InquiryCommentDTO> commentIWrote(Map<String,Object> ownerId) { // 나의 활동 댓글 리스트
        return sql.selectList("comment.commentIWrote", ownerId);
    }

    public void keepLogin(String owner_Id, String session_key, Date session_limit) throws Exception{
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("owner_Id", owner_Id);
        paramMap.put("session_key", session_key);
        paramMap.put("session_limit", session_limit);
        sql.update("animal.keepLogin", paramMap);
    }

    public AnimalMemberDTO checkUserWitSessionKey(String value) throws Exception{
        return sql.selectOne("animal.checkUserWitSessionKey", value);
    }
}
