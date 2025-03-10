package com.review.dto.animal;

import lombok.Data;

@Data
public class AnimalMedicalRecordDTO {

    /**
     RECORD_ID INT AUTO_INCREMENT PRIMARY KEY,  				-- 진료 기록 ID (자동 생성)
     PET_ID VARCHAR(20) NOT NULL,              			    	-- 동물 아이디 (Pet_Tbl의 외래키)
     PET_NAME VARCHAR(20) NOT NULL,							    -- 이름
     PET_AGE VARCHAR(10) NOT NULL,                      		-- 생년월일
     CALCULATED_AGE VARCHAR(10),                          		-- 나이
     DATE_OF_VISIT TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,    -- 진료 날짜
     SYMPTOMS VARCHAR(500) NOT NULL,            				-- 증상
     DIAGNOSIS VARCHAR(500) NOT NULL,           				-- 진단
     TREATMENT VARCHAR(500) NOT NULL,           				-- 치료
     PRESCRIPTION VARCHAR(500) NOT NULL,        				-- 처방
     DOCTOR VARCHAR(20) NOT NULL,
     FOREIGN KEY (PET_ID) REFERENCES Pet_Tbl(PET_ID)
     * **/

    private int record_Id;
    private String pet_Id;
    private String pet_Name;
    private String pet_Age;
    private String calculated_age;
    private String date_Of_Visit;
    private String symptoms;
    private String diagnosis;
    private String treatment;
    private String prescription;
    private String doctor;
}
