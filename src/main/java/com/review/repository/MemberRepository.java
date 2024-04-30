package com.review.repository;


import com.review.dto.MemberDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
@RequiredArgsConstructor
public class MemberRepository {

    @Setter(onMethod_ = @Autowired)
    private SqlSessionTemplate sql;

    public int joinMembership(MemberDTO memberDTO) {                /** 회원가입 **/

        return sql.insert("Member.join", memberDTO);
    }

    public int EmailJoinCheck(String Email) {                       /** 회원가입 e-mail체크 **/

        return  sql.selectOne("Member.EmailCheck", Email);
    }

    public MemberDTO userConfirmation(MemberDTO memberDTO) {         /** 로그인  **/
        return sql.selectOne("Member.login", memberDTO);
    }


}
