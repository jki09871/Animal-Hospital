package com.review.dto;

import lombok.Data;

import java.util.Date;

@Data
public class AnimalReviewDTO {

    private int reviewNum;
    private String title;
    private String content;
    private String writer;
    private Date regdate;
    private Date updateDate;

}
