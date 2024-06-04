package com.review.dto.animal;

import lombok.Data;

@Data
public class PetDTO {

    private String owner_Id;
    private String pet_Id;
    private String pet_name;
    private String species;
    private String age;
    private String significant;
    private String phoneNumber;
}
