package com.review.repository;

import com.review.dto.PetDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Component
@RequiredArgsConstructor
public class PetRepository {

    @Setter(onMethod_ = @Autowired)
    private SqlSessionTemplate sql;
    public void petInfoSave(PetDTO petDTO) {
        sql.insert("Pet.infoSave", petDTO);
    }

    public List<PetDTO> getPetInfo(String ownerId) {
        return sql.selectList("Pet.PetInfo", ownerId);
    }

    public PetDTO petINfoModify(String pet_Id) {
        return sql.selectOne("Pet.InfoModify", pet_Id);
    }

    public void petInfoUpdate(PetDTO petDTO) {
        sql.update("Pet.InfoUpdate", petDTO);
    }

    public void petInfoDelete(String pet_Id) {
        sql.delete("Pet.InfoDelete", pet_Id);
    }
}
