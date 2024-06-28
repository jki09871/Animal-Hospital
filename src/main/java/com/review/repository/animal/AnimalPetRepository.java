package com.review.repository.animal;

import com.review.dto.animal.AnimalDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Log4j
@Component
@RequiredArgsConstructor
public class AnimalPetRepository {

    @Setter(onMethod_ = @Autowired)
    private SqlSessionTemplate sql;
    public void petInfoSave(AnimalDTO petDTO) {
        sql.insert("Pet.infoSave", petDTO);
    }

    public List<AnimalDTO> getPetInfo(String ownerId) {
        return sql.selectList("Pet.PetInfo", ownerId);
    }

    public AnimalDTO petINfoModify(String pet_Id) {
        return sql.selectOne("Pet.InfoSelect", pet_Id);
    }

    public void petInfoUpdate(AnimalDTO petDTO) {
        sql.update("Pet.InfoUpdate", petDTO);
    }

    public void petInfoDelete(String pet_Id) {
        sql.delete("Pet.InfoDelete", pet_Id);
    }
}
