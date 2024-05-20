package com.review.service.animal;

import com.review.dto.animal.PetDTO;
import com.review.dto.animal.PetMedicalRecordDTO;
import com.review.paging.PagingCriteria;
import com.review.repository.animal.MedicalRecordRepository;
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
public class MedicalRecordService {

    @Setter(onMethod_ = @Autowired)
    private MedicalRecordRepository recordRepository;

    public void prescription(PetMedicalRecordDTO recordDTO) {
        recordRepository.prescription(recordDTO);
    }
    public List<PetDTO> recordList(PagingCriteria pagingCriteria){
        return recordRepository.recordList(pagingCriteria);
    }

    public List<Map<String, Object>> prescriptionDetails(Map<String , Object> multiple) {
        return recordRepository.prescriptionDetails(multiple);
    }

    public PetMedicalRecordDTO recordEdit(PetMedicalRecordDTO recordDTO) {
        return recordRepository.recordEdit(recordDTO);
    }

    public void editAndSend(PetMedicalRecordDTO recordDTO) {
         recordRepository.editAndSend(recordDTO);
    }

    public int postTotal(PagingCriteria cri) {
        return recordRepository.postTotal(cri);
    }
}
