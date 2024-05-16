package com.review.repository.animal;

import com.review.controller.animal.PetMedicalRecordController;
import com.review.dto.animal.PetDTO;
import com.review.dto.animal.PetMedicalRecordDTO;
import com.review.paging.PagingCriteria;
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

    public List<PetDTO> recordList(PagingCriteria pagingCriteria){
        return sql.selectList("record.recordList", pagingCriteria);
    }

    public List<PetMedicalRecordDTO> prescriptionDetails(PetMedicalRecordDTO recordDTO) {
        return sql.selectList("record.read", recordDTO);
    }

    public PetMedicalRecordDTO recordEdit(PetMedicalRecordDTO recordDTO) {
        return sql.selectOne("record.edit", recordDTO);
    }

    public void editAndSend(PetMedicalRecordDTO recordDTO) {
        sql.update("record.editSend", recordDTO);
    }

    public int postTotal(PagingCriteria cri) {
        return sql.selectOne("record.postTotal", cri);
    }
}
