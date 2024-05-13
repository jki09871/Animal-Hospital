package com.review.controller.animal;

import com.review.dto.animal.PetMedicalRecordDTO;
import com.review.paging.PageMakerDTO;
import com.review.paging.PagingCriteria;
import com.review.service.animal.MedicalRecordService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        return "redirect:/pet/prescription/list";
    }

    @GetMapping("/pet/prescription/list")
    public String prescriptionList( Model model, PagingCriteria cri, HttpServletRequest request){
        model.addAttribute("recordList", recordService.recordList(cri));



//        model.addAttribute("pageNum", request.getParameter("pageNum"));
//        model.addAttribute("amount", request.getParameter("amount"));


        int total = recordService.postTotal(cri);
        PageMakerDTO pageMaker = new PageMakerDTO(cri, total);
        model.addAttribute("pageMaker", pageMaker);
        return "/animal/record/list";
    }

    @GetMapping("/pet/prescription/details")
    public String prescriptionRead(PetMedicalRecordDTO recordDTO, Model model,HttpServletRequest request){

        model.addAttribute("keyword", request.getParameter("keyword"));
        model.addAttribute("pageNum", request.getParameter("pageNum"));
        model.addAttribute("amount", request.getParameter("amount"));


        List<PetMedicalRecordDTO> readList = recordService.prescriptionDetails(recordDTO);
        model.addAttribute("read",readList);

        return "/animal/record/read";
    }

    @GetMapping("/pet/prescription/edit")
    public String prescriptionEdit(PetMedicalRecordDTO recordDTO, Model model, HttpServletRequest request){

        model.addAttribute("pageNum", request.getParameter("pageNum"));
        model.addAttribute("amount", request.getParameter("amount"));
        model.addAttribute("keyword", request.getParameter("keyword"));


        model.addAttribute("edit",recordService.recordEdit(recordDTO));
        return "/animal/record/edit";
    }

    @PostMapping("/pet/prescription/edit")
    public String sendCorrectedPrescription(PetMedicalRecordDTO recordDTO, HttpServletRequest request, RedirectAttributes rttr){
        recordService.editAndSend(recordDTO);
        recordService.prescriptionDetails(recordDTO);

        rttr.addAttribute("record_Id", request.getParameter("record_Id"));
        rttr.addAttribute("pageNum", request.getParameter("pageNum"));
        rttr.addAttribute("amount", request.getParameter("amount"));
        rttr.addAttribute("keyword", request.getParameter("keyword"));


        return "redirect:/pet/prescription/details/unravel";
    }

    @GetMapping("/pet/prescription/details/unravel")
    public String prescriptionUnravel(PetMedicalRecordDTO recordDTO, Model model, HttpServletRequest request){
        model.addAttribute("pageNum", request.getParameter("pageNum"));
        model.addAttribute("amount", request.getParameter("amount"));
        model.addAttribute("keyword", request.getParameter("keyword"));

        model.addAttribute("read",recordService.recordEdit(recordDTO));


        return "/animal/record/unravel";
    }
}
