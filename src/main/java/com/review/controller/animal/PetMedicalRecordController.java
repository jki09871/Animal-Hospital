package com.review.controller.animal;

import com.review.dto.animal.PetMedicalRecordDTO;
import com.review.service.animal.MedicalRecordService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;

@Log4j
@Controller
@RequiredArgsConstructor
public class PetMedicalRecordController {

    @Setter(onMethod_ = @Autowired)
    private MedicalRecordService recordService;

    @GetMapping("/pet/prescription/record")
    public String writePrescription(){
        return "/animal/record/prescription";
    }

    @PostMapping("/pet/prescription/record")
    public String writePrescription(PetMedicalRecordDTO recordDTO){
        recordService.prescription(recordDTO);
        return "redirect:/animal/record/list";
    }

    @GetMapping("/pet/prescription/list")
    public String prescriptionList(PetMedicalRecordDTO recordDTO, Model model){
        List<PetMedicalRecordDTO> recordList = recordService.recordList(recordDTO);
        model.addAttribute("recordList", recordList);
        return "/animal/record/list";
    }

    @GetMapping("/pet/prescription/details")
    public String prescriptionRead(PetMedicalRecordDTO recordDTO, Model model){
        List<PetMedicalRecordDTO> readList = recordService.prescriptionDetails(recordDTO);
        model.addAttribute("read",readList);

        return "/animal/record/read";
    }
}
