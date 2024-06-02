package com.review.dto.animal;

import lombok.Data;

import java.util.Date;

@Data
public class InquiryCommentDTO {

    /**
     * CREATE TABLE INQUIRY_COMMENT_TBL(
     * ID BIGINT primary key auto_increment,					-- 번호
     * commentWriter varchar(50),								-- 댓글 작성자
     * commentContent varchar(200),							    -- 댓글 내용
     * BOARDID int,									            -- 문의 번호
     * commentCreateTime TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, -- 댓글 시간
     * FOREIGN KEY (BOARDID) references INQUIRY_TBL(INQUIRYNUM) ON DELETE CASCADE -- 제약 조건 게시글이 삭제 되면 댓글도 함께 삭제
     * );
     * **/

    private Long id;
    private String comment_Writer;
    private String comment_Content;
    private int inquiry_num;
    private Date comment_Create_Time;
    private String title;
}
