package com.review.repository.animal;

import com.review.dto.animal.AnimalNonMembersDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Log4j
@Component
@RequiredArgsConstructor
public class AnimalNonMemberRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;

    public void nonMembersRegister(AnimalNonMembersDTO memberDTO) {
        sql.insert("nonMembers.register", memberDTO);

    }

    public int registeredMemberCount(AnimalNonMembersDTO memberDTO) {
        return sql.selectOne("nonMembers.registeredMemberCount",memberDTO);
    }
}
