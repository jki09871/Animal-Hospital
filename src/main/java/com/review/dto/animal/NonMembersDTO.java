package com.review.dto.animal;

import lombok.Data;

import java.util.Date;

@Data
public class NonMembersDTO {

    private String name;
    private String email;
    private String poneNumber;
    private Date regDate;
}
