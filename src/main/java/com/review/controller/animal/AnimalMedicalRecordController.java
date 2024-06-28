package com.review.controller.animal;

import com.review.dto.animal.AnimalMedicalRecordDTO;
import com.review.paging.PageMakerDTO;
import com.review.paging.PagingCriteria;
import com.review.service.animal.AnimalMedicalRecordService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalMedicalRecordController {

    @Setter(onMethod_ = @Autowired)
    private AnimalMedicalRecordService recordService;

    /*******************************************  처방전 작성  ********************************************/

    @GetMapping("/pet/prescription/record")
    public String writePrescription(){
        return "/animal/record/prescription";
    }

    @PostMapping("/pet/prescription/record")
    public String writePrescription(AnimalMedicalRecordDTO recordDTO){
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
    public ModelAndView prescriptionRead(PagingCriteria cri,HttpServletResponse response, @RequestParam(value = "pet_Id", required = false) String pet_Id,
                                                             @RequestParam(value = "endTime", required = false) String endTime,
                                                             @RequestParam(value = "startTime", required = false) String startTime){

        ModelAndView view = new ModelAndView();
        Map<String , Object> multiple = new HashMap<>();
        multiple.put("pet_Id", pet_Id);
        multiple.put("startTime", startTime);
        multiple.put("endTime", endTime);

        Cookie cookie = new Cookie("pet_Id", pet_Id);
        response.addCookie(cookie);




        List<Map<String,Object>> readList = recordService.prescriptionDetails(multiple);

        view.setViewName("/animal/record/read");
        view.addObject("cri", cri);
        view.addObject("read", readList);
        view.addObject("Time", multiple);

        return view;
    }
    /************************************************************************************************************/

    /***************************************  처방전 수정  ********************************************/


    @GetMapping("/pet/prescription/edit")
    public String prescriptionEdit(AnimalMedicalRecordDTO recordDTO, Model model, PagingCriteria cri){

        model.addAttribute("cri", cri);

        model.addAttribute("edit",recordService.recordEdit(recordDTO));
        return "/animal/record/edit";
    }

    @PostMapping("/pet/prescription/edit")
    public String sendCorrectedPrescription(AnimalMedicalRecordDTO recordDTO, HttpServletRequest request,
                                            PagingCriteria cri, RedirectAttributes rttr){
        recordService.editAndSend(recordDTO);

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
    public String prescriptionUnravel(AnimalMedicalRecordDTO recordDTO, Model model, PagingCriteria cri){
        model.addAttribute("cri", cri);


        model.addAttribute("read",recordService.recordEdit(recordDTO));


        return "/animal/record/unravel";
    }
    /************************************************************************************************************/

}
