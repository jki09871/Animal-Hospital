package com.review.dto;

import lombok.Data;

import java.util.Date;

/**

        REVIEWNUM int auto_increment primary key, 								-- 리뷰 번호 --
        REVIEWTITLE varchar(50) not null,											-- 리뷰 제목 --
        REVIEWCONTENT varchar(2000) not null,										-- 리뷰 내용 --
        REVIEWWRITER varchar(20) not null,											-- 리뷰 작성자 --
        REVIEWREGDATE timestamp NULL DEFAULT CURRENT_TIMESTAMP,						-- 리뷰 작성시간 --
        REVIEWUPDATEDATE timestamp NULL DEFAULT CURRENT_TIMESTAMP					-- 리뷰 수정시간 --
*/
@Data
public class AnimalReviewDTO {

    private int reviewNum;
    private String reviewTitle;
    private String reviewContent;
    private String reviewWriter;
    private Date reviewregdate;
    private Date reviewUpdate;

}
