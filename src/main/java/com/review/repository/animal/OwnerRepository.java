package com.review.repository.animal;

import com.review.dto.animal.AnimalMemberDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
}
