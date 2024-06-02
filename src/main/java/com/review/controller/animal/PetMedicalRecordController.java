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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
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
    @ResponseBody
    public ModelAndView prescriptionRead(PetMedicalRecordDTO recordDTO, PagingCriteria cri, Model model, RedirectAttributes rttr,
                                         @RequestParam(value = "pet_Id", required = false) Integer pet_Id,
                                         @RequestParam(value = "endTime", required = false) String endTime,
                                         @RequestParam(value = "startTime", required = false) String startTime){

        Map<String , Object> multiple = new HashMap<>();
        multiple.put("pet_Id", pet_Id);
        multiple.put("startTime", startTime);
        multiple.put("endTime", endTime);

        List<Map<String,Object>> readList = recordService.prescriptionDetails(multiple);
        ModelAndView view = new ModelAndView();

        int size = readList.size();
        if (size <= 0){
            rttr.addAttribute("cri", cri);
            rttr.addAttribute("read", readList);
            rttr.addAttribute("pet_Id", pet_Id);
            view.setViewName("redirect:/pet/prescription/details");
            return view;
        }


        view.setViewName("/animal/record/read");
        view.addObject("cri", cri);
        view.addObject("read", readList);

        return view;
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
        recordService.prescriptionDetails((Map<String, Object>) recordDTO);

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


//    @PostMapping("/pet/prescription/details/time")
//    @ResponseBody
//    public String timeSearch (@RequestParam("startTime")Date startTime,
//                              @RequestParam("endTime")Date endTime){
//
//        System.out.println("startTime = " + startTime);
//        System.out.println("endTime = " + endTime);
//        return null;
//    }
}
