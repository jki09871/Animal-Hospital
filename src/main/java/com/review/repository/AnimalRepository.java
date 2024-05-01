package com.review.repository;

import com.review.dto.AnimalMemberDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
@Log4j
@RequiredArgsConstructor
public class AnimalRepository {

    private final SqlSessionTemplate sql;


    public int PostSignupScreen(AnimalMemberDTO animalDTO) {
       return sql.insert("animal.signup", animalDTO);
    }

    public AnimalMemberDTO UserVerification(AnimalMemberDTO animalDTO) {
        return sql.selectOne("animal.login", animalDTO);
    }

    public int JoinEmailCheck(Map<String, Object> valid) {

        return sql.selectOne("animal.EmailCheck", valid);
    }
}
