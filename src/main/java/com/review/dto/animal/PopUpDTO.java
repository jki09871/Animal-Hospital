package com.review.dto.animal;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/*
*
    CREATE TABLE POPUP(
    ID int primary key auto_increment,                          -- 고유 ID
    TITLE VARCHAR(255) NOT NULL,                                -- 제목
    CONTENT VARCHAR(1000) NOT NULL,                             -- 내용
    IMAGE_URL VARCHAR(255),                                     -- 이미지 full url
    LINK_URL VARCHAR(255),                                      -- 링크 url
    START_DATE DATETIME NOT NULL,                               -- 팝업 시작 시간
    END_DATE DATETIME NOT NULL,                                 -- 팝업 종료 시간
    STATUS ENUM('ACTIVE', 'INACTIVE', 'ARCHIVED') NOT NULL      -- 팝업 상태 (활성화/비활성화)
    STORED_FILE_NAME (VARCHAR(50)                               -- 저장된 이미지 이름
    FOLDER_NM(VARCHAR(20))                                      -- 저장된 이미지 폴더명
);
* */

@Data
public class PopUpDTO {

    private int id;
    private String title;
    private String content;
    private String image_full_url;
    private String link_url;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date start_date;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date end_date;
    private Status status;
    private String folder_nm;
    private String stored_file_name;

    public enum Status {
        ACTIVE, INACTIVE
    }
}
