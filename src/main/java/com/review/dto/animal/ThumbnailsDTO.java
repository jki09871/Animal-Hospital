package com.review.dto.animal;

import lombok.Data;

@Data
/**
 * CREATE TABLE THUMBNAILS_TBL(
 *     `THUMBNAILS_ID` int NOT NULL AUTO_INCREMENT PRIMARY KEY, -- 고유 아이디
 *     `MULTI_ID` int DEFAULT NULL,                             -- 파일이 등록된 게시판 번호
 *     `ORG_FILE_NAME` varchar(260) NOT NULL,                   -- 파일 실제 이름
 *     `STORED_FILE_NAME` varchar(50) NOT NULL,                 -- 저장된 파일 이름
 *     `FILE_SIZE` int DEFAULT NULL,                            -- 파일 사이즈
 *     `REGDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- 저장된 시간
 *     `FOLDER_NM` varchar(20) DEFAULT NULL,                    -- 사진이 저장된 폴더 이름
 * );
 * */
public class ThumbnailsDTO {

    private int thumbnails_id;
    private int multi_id;
    private String org_file_name;
    private String stored_file_name;
    private String file_size;
    private String regDate;
    private String folder_nm;
}



