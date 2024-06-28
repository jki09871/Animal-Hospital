package com.review.repository.animal;


import com.review.dto.animal.AnimalMemberDTO;
import com.review.dto.animal.AnimalDTO;
import com.review.paging.PagingCriteria;
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
public class AnimalSiteAdministratorRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;

    public List<AnimalMemberDTO> memberList() {
        return sql.selectList("manager.memberList");
    }

    public AnimalMemberDTO memberData(AnimalMemberDTO memberDTO) {
        return sql.selectOne("manager.memberData", memberDTO);
    }

    public List<AnimalDTO> petList(PagingCriteria cri) {
        return sql.selectList("manager.petList", cri);
    }

    public AnimalDTO petData(AnimalDTO petDTO) {
        return sql.selectOne("manager.petData", petDTO);
    }

    public int registeredAnimal(PagingCriteria cri) {
        return sql.selectOne("manager.postTotal", cri);
    }
}
