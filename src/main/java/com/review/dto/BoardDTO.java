package com.review.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class BoardDTO {

    private int bno;
    private String title;
    private String content;
    private String writer;
    private Date time;
    private int hits;
}
