package com.review.dto.animal;

import lombok.Data;


/**
CREATE TABLE ADOPTION_TBL
(
    ADOPTION_ID INT AUTO_INCREMENT PRIMARY KEY,         -- 고유 아이디
    ANIAML_NAME VARCHAR(20) NOT NULL,                   -- 입양할 동물 이름
    AGE VARCHAR(20),                                    -- 나이
    SPECIES VARCHAR(20)  NOT NULL,                      -- 종
    GENDER CHAR(1) NOT NULL,                            -- 성별
    INOCULATION VARCHAR(1000) NOT NULL,                 -- 접장
    ILIKE VARCHAR(200) NULL,                            -- 좋아하는 것
    DISLIKE VARCHAR(200) NULL,                          -- 싫어하는 것
    NEUTERING CHAR(1) NOT NULL,                         -- 중성화 유/무
    SIGNIFICANT VARCHAR(1000) NULL                      -- 특이이상
);
* */

@Data
public class AnimalAdoptionDTO {

    private int adoption_id;
    private String animal_name;
    private String age;
    private String species;
    private char gender;
    private String inoculation;
    private String iLike;
    private String disLike;
    private char neutering;
    private String significant;
}
