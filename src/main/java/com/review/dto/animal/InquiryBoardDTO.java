package com.review.dto.animal;

import lombok.Data;

import java.util.Date;

@Data
public class InquiryBoardDTO {

    /**
     * CREATE TABLE `tbl_inquiry` (
     *   `inquiryNum` int NOT NULL AUTO_INCREMENT,					-- 문의번호
     *   `title` varchar(150) DEFAULT NULL,						    -- 문의 제목
     *   `content` varchar(2000) DEFAULT NULL,						-- 문의 내용
     *   `writer` varchar(50) DEFAULT NULL,						    -- 작성자
     *   `regdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,		-- 작성시간
     *   `updatedate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,	    -- 수정시간
     *   `OWNER_ID` varchar(20) DEFAULT NULL,                       -- 회원 비회원 확인
     *   `PASSWORD` varchar(250) DEFAULT NULL,                      -- 비공개이면 비밀번호
     *   PRIMARY KEY (`inquiryNum`)
     * );
    * **/
    private Long inquiry_Num;
    private String title;
    private String content;
    private String writer;
    private String owner_Id;
    private String password;
    private Date regdate;
    private Date update_Date;
}