package com.review.repository.animal;

import com.review.dto.animal.AnimalAdoptionDTO;
import com.review.service.animal.AnimalAdoptionService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
@RequiredArgsConstructor
public class AnimalAdoptionRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;

    public void adoptionAnimalRegister(AnimalAdoptionDTO adoptionDTO) {
        sql.insert("adoption.register", adoptionDTO);
    }

    public List<AnimalAdoptionDTO> adoptionAnimalList(){
        return sql.selectList("adoption.animalList");
    }

    public AnimalAdoptionDTO adoptionAnimalRead(AnimalAdoptionDTO adoptionDTO) {
        return sql.selectOne("adoption.animalRead", adoptionDTO);
    }

    public void adoptionAnimalInformationModify(AnimalAdoptionDTO adoptionDTO) {
        sql.update("adoption.informationModify", adoptionDTO);

    }

    public int adoptionIdMaxCount(){
        return sql.selectOne("adoption.idMaxCount");
    }

    public void insertFile(Map<String, Object> map) {
        sql.insert("file.insertFile", map);
    }

    public void thumbnailsFileSave(Map<String, Object> map) {
        sql.insert("file.thumbnails", map);
    }
}
