package com.review.repository.animal;

import com.review.controller.animal.PetMedicalRecordController;
import com.review.dto.animal.PetMedicalRecordDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Log4j
@RequiredArgsConstructor
public class MedicalRecordRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;

    public void prescription(PetMedicalRecordDTO recordDTO) {
        sql.insert("record.write", recordDTO);
    }

    public List<PetMedicalRecordDTO> recordList(PetMedicalRecordDTO recordDTO){
        return sql.selectList("record.recordList", recordDTO);
    }

    public List<PetMedicalRecordDTO> prescriptionDetails(PetMedicalRecordDTO recordDTO) {
        return sql.selectList("record.read", recordDTO);
    }
}
