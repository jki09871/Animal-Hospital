package com.review.dto.animal;

import lombok.Data;


/**
CREATE TABLE ADOPTION_TBL
(
    ADOPTION_ID INT AUTO_INCREMENT PRIMARY KEY,         -- 고유 아이디
    ANIAML_NAME VARCHAR(20) NOT NULL,                   -- 입양할 동물 이름
    CONTENT VARCHAR(2000) NOT NULL,                     -- 강아지 설명
    AGE VARCHAR(20),                                    -- 나이
    SPECIES VARCHAR(20)  NOT NULL,                      -- 종
    GENDER CHAR(1) NOT NULL,                            -- 성별
    INOCULATION VARCHAR(1000) NOT NULL,                 -- 접종
    ILIKE VARCHAR(200) NULL,                            -- 좋아하는 것
    DISLIKE VARCHAR(200) NULL,                          -- 싫어하는 것
    NEUTERING CHAR(1) NOT NULL,                         -- 중성화 유/무
    SIGNIFICANT VARCHAR(1000) NULL                      -- 특이이상
    STORED_FILE_NAME VARCHAR(50) NOT NULL,              -- 저장된 파일 이름
    LINK_URL VARCHAR(255) NOT NULL,                     -- 사진 클릭시 필요한 링크
    FOLDER_NM VARCHAR(20) NOT NULL                      -- 저장된 사진 폴더이름
);
* */

@Data
public class AnimalAdoptionDTO {

    private int adoption_id;
    private String animal_name;
    private String age;
    private String species;
    private String gender;
    private String inoculation;
    private String iLike;
    private String disLike;
    private String neutering;
    private String content;
    private String stored_file_name;
    private String folder_nm;
    private String adoptionStatus;
}
