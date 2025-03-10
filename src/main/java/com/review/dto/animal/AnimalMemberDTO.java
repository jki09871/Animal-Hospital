package com.review.dto.animal;

import lombok.Data;

import java.util.Date;

@Data
public class AnimalMemberDTO {

/**

         OWNERId varchar(20) unique not null , 	 		 -- 주인 아이디 --
         OWNERPASSWORD varchar (20) not null,			 -- 주인 비밀번호 --
         OWNEREMAIL varchar (40) not null,				 -- 주인 이메일 --
         OWNERPHONENUMBER varchar(20) not null,			 -- 주인 전화번호 --
         OWNERGRADE int DEFAULT 0,					     -- 등급 = 운영자 와 회원의 차이를 두려고 --
         OWNERREGDATE timestamp							 -- 가입 날짜 --
 **/

    private String owner_Id;
    private String owner_nm;
    private String password;
    private String email;
    private String phoneNumber;
    private int grade;
    private Date regDate;
    private int post;
    private int comment;
    private int inquiry;
    private String session_key;
    private Date session_limit;
    private Date pwdExpires;
    private String change_at;
    private int pwFailCount;
}
