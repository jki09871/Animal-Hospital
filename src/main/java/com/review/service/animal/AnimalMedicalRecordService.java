package com.review.service.animal;

import com.review.dto.animal.AnimalDTO;
import com.review.dto.animal.AnimalMedicalRecordDTO;
import com.review.paging.PagingCriteria;
import com.review.repository.animal.AnimalMedicalRecordRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Log4j
public class AnimalMedicalRecordService {

    @Setter(onMethod_ = @Autowired)
    private AnimalMedicalRecordRepository recordRepository;

    public void prescription(AnimalMedicalRecordDTO recordDTO) {
        recordRepository.prescription(recordDTO);
    }
    public List<AnimalDTO> recordList(PagingCriteria pagingCriteria){
        return recordRepository.recordList(pagingCriteria);
    }

    public List<Map<String, Object>> prescriptionDetails(Map<String , Object> multiple) {
        return recordRepository.prescriptionDetails(multiple);
    }

    public AnimalMedicalRecordDTO recordEdit(AnimalMedicalRecordDTO recordDTO) {
        return recordRepository.recordEdit(recordDTO);
    }

    public void editAndSend(AnimalMedicalRecordDTO recordDTO) {
         recordRepository.editAndSend(recordDTO);
    }

    public int postTotal(PagingCriteria cri) {
        return recordRepository.postTotal(cri);
    }
}
