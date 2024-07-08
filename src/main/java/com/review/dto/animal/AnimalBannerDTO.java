package com.review.dto.animal;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;


/**
 *     CREATE TABLE BANNER_TBL(
 *     BANNER_ID INT AUTO_INCREMENT PRIMARY KEY ,          -- 배너 고유 번호
 *     TITLE VARCHAR(255) NOT NULL,                        -- 배너 제목
 *     CONTENT VARCHAR(2000) NOT NULL ,                    -- 배너 내용
 *     IMAGE_FULL_URL VARCHAR(255) NOT NULL ,              -- 저장된 이미지 전체 URL
 *     LINK_URL VARCHAR(255) NULL,                         -- 이미지 클릭시 이동될 URL
 *     START_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,      -- 배너 시작 시간
 *     END_DATE DATETIME DEFAULT CURRENT_TIMESTAMP,        -- 배넌 끝 시간
 *     FOLDER_NM VARCHAR(20),                              -- 이미지 저장된 폴더 이름
 *     STORED_FILE_NAME VARCHAR(50),                       -- 이미지 저장된 이름
 *     STATUS ENUM('ACTIVE','INACTIVE') NOT NULL           -- 배너 활성/비활성(상태 확인)
 *     );
* */
@Data
public class AnimalBannerDTO {

    private int banner_id;
    private String title;
    private String content;
    private String image_full_url;
    private String link_url;
    private String folder_nm;
    private String stored_file_name;
    private Status status;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date start_date;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date end_date;
    private String valid_time;

    public enum Status {
        ACTIVE, INACTIVE
    }
}
