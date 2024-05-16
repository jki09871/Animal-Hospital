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

    /*******************************************  처방전 작성  ********************************************/

    @GetMapping("/pet/prescription/record")
    public String writePrescription(){
        return "/animal/record/prescription";
    }

    @PostMapping("/pet/prescription/record")
    public String writePrescription(PetMedicalRecordDTO recordDTO){
        recordService.prescription(recordDTO);
        return "redirect:/pet/prescription/list";
    }
    /************************************************************************************************************/

    /*******************************************  처방전 리스트  ********************************************/

    @GetMapping("/pet/prescription/list")
    public String prescriptionList( Model model, PagingCriteria pagingCriteria, HttpServletRequest request){


        int total = recordService.postTotal(pagingCriteria);
        model.addAttribute("recordList", recordService.recordList(pagingCriteria));
        model.addAttribute("pageMaker", new PageMakerDTO(pagingCriteria, total));


        return "/animal/record/list";
    }
    /************************************************************************************************************/

    /***************************************  pet_id로 확인하는 처방전  ********************************************/


    @GetMapping("/pet/prescription/details")
    public String prescriptionRead(PetMedicalRecordDTO recordDTO,PagingCriteria cri, Model model){

        model.addAttribute("cri", cri);



        List<PetMedicalRecordDTO> readList = recordService.prescriptionDetails(recordDTO);
        model.addAttribute("read",readList);

        return "/animal/record/read";
    }
    /************************************************************************************************************/

    /***************************************  처방전 수정  ********************************************/


    @GetMapping("/pet/prescription/edit")
    public String prescriptionEdit(PetMedicalRecordDTO recordDTO, Model model,PagingCriteria cri){

        model.addAttribute("cri", cri);

        model.addAttribute("edit",recordService.recordEdit(recordDTO));
        return "/animal/record/edit";
    }

    @PostMapping("/pet/prescription/edit")
    public String sendCorrectedPrescription(PetMedicalRecordDTO recordDTO, HttpServletRequest request,
                                            PagingCriteria cri, RedirectAttributes rttr){
        recordService.editAndSend(recordDTO);
        recordService.prescriptionDetails(recordDTO);

        rttr.addAttribute("record_Id", request.getParameter("record_Id"));
        rttr.addAttribute("pageNum", request.getParameter("pageNum"));
        rttr.addAttribute("amount", request.getParameter("amount"));
        rttr.addAttribute("keyword", request.getParameter("keyword"));
        rttr.addAttribute("type", request.getParameter("type"));

        return "redirect:/pet/prescription/details/unravel";
    }
    /************************************************************************************************************/

    /***************************************  처방전 상세  ********************************************/

    @GetMapping("/pet/prescription/details/unravel")
    public String prescriptionUnravel(PetMedicalRecordDTO recordDTO, Model model, PagingCriteria cri){
        model.addAttribute("cri", cri);


        model.addAttribute("read",recordService.recordEdit(recordDTO));


        return "/animal/record/unravel";
    }
    /************************************************************************************************************/

}
