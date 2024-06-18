package com.review.repository.animal;

import com.review.dto.animal.NonMembersDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Log4j
@Component
@RequiredArgsConstructor
public class NonMemberRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;

    public void nonMembersRegister(NonMembersDTO memberDTO) {
        sql.insert("nonMembers.register", memberDTO);

    }

    public int registeredMemberCount(NonMembersDTO memberDTO) {
        return sql.selectOne("nonMembers.registeredMemberCount",memberDTO);
    }
}
