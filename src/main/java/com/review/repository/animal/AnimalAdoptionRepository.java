package com.review.repository.animal;

import com.review.dto.animal.AnimalAdoptionDTO;
import com.review.service.animal.AnimalAdoptionService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class AnimalAdoptionRepository {

    @Setter(onMethod_ = @Autowired)
    private SqlSessionTemplate sql;

    public void adoptionAnimalRegister(AnimalAdoptionDTO adoptionDTO) {
        sql.insert("adoption.register", adoptionDTO);
    }
}
