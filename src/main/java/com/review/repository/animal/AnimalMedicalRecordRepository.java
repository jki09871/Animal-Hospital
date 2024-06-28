package com.review.repository.animal;

import com.review.dto.animal.AnimalDTO;
import com.review.dto.animal.AnimalMedicalRecordDTO;
import com.review.paging.PagingCriteria;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Log4j
@RequiredArgsConstructor
public class AnimalMedicalRecordRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;

    public void prescription(AnimalMedicalRecordDTO recordDTO) {
        sql.insert("record.write", recordDTO);
    }

    public List<AnimalDTO> recordList(PagingCriteria pagingCriteria){
        return sql.selectList("record.recordList", pagingCriteria);
    }

    public List<Map<String,Object>> prescriptionDetails(Map<String, Object> multiple) {
        return sql.selectList("record.read", multiple);
    }

    public AnimalMedicalRecordDTO recordEdit(AnimalMedicalRecordDTO recordDTO) {
        return sql.selectOne("record.edit", recordDTO);
    }

    public void editAndSend(AnimalMedicalRecordDTO recordDTO) {
        sql.update("record.editSend", recordDTO);
    }

    public int postTotal(PagingCriteria cri) {
        return sql.selectOne("record.postTotal", cri);
    }
}
