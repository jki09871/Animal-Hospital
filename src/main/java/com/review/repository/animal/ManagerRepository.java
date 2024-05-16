package com.review.repository.animal;


import com.review.dto.animal.AnimalMemberDTO;
import com.review.dto.animal.PetDTO;
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
public class ManagerRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;

    public List<AnimalMemberDTO> memberList() {
        return sql.selectList("manager.memberList");
    }


    public List<PetDTO> petList() {
        return sql.selectList("manager.petList");
    }
}
