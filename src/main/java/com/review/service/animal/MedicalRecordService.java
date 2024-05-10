package com.review.service.animal;

import com.review.dto.animal.PetMedicalRecordDTO;
import com.review.repository.animal.MedicalRecordRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Log4j
public class MedicalRecordService {

    @Setter(onMethod_ = @Autowired)
    private MedicalRecordRepository recordRepository;

    public void prescription(PetMedicalRecordDTO recordDTO) {
        recordRepository.prescription(recordDTO);
    }
    public List<PetMedicalRecordDTO> recordList(PetMedicalRecordDTO recordDTO){
        return recordRepository.recordList(recordDTO);
    }

    public List<PetMedicalRecordDTO> prescriptionDetails(PetMedicalRecordDTO recordDTO) {
        return recordRepository.prescriptionDetails(recordDTO);
    }
}
