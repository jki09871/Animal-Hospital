package com.review.controller;

import com.review.dto.PetDTO;
import com.review.service.PetService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalController {

    @Setter(onMethod_ = @Autowired)
    private PetService ps;

    /************************************************  동물 등록  ************************************************/
    @GetMapping("/pet/info/write")
    public String petInfoWrite(@RequestParam("ownerId") String ownerId, Model model){
        model.addAttribute("ownerId", ownerId);
        log.info("애완동물 정보 쓰기");
        return "/animal/pet/infoWrite";
    }

    @PostMapping("/pet/info/write")
    public String petInfoWrite(PetDTO petDTO, RedirectAttributes rttr){

        log.info(petDTO);
        ps.petInfoSave(petDTO);
        ps.getPetInfo(petDTO.getPet_Id());
        rttr.addAttribute("ownerId", petDTO.getOwner_Id());
        return "redirect:/pet/info";
    }
    /************************************************************************************************************/
    /************************************************  등록 정보  ************************************************/

    @GetMapping("/pet/info")
    public String petInfo(@RequestParam ("ownerId") String ownerId , Model model){
        model.addAttribute("pet", ps.getPetInfo(ownerId));

        return "/animal/pet/info";
    }
    /************************************************************************************************************/

    /************************************************  등록 수정  ************************************************/
    @GetMapping("/pet/info/modify")
    public String petInfoUpdate(@RequestParam ("pet_Id") String pet_Id , Model model, HttpServletRequest request){



        model.addAttribute("pet", ps.petInfoModify(pet_Id));
        return "/animal/pet/infoModify";
    }

    @PostMapping("/pet/info/modify")
    public String petInfoUpdate(PetDTO petDTO, RedirectAttributes rttr, @RequestParam("owner_Id") String owner_Id){
        System.out.println("petDTO = " + petDTO);
            ps.petInfoUpdate(petDTO);

        rttr.addAttribute("ownerId", owner_Id);
        ps.getPetInfo(petDTO.getOwner_Id());
        return "redirect:/pet/info";
    }
    /************************************************************************************************************/

    /********************************************  동물 정보 삭제  ************************************************/
    @PostMapping("/pet/info/delete")
    public String petInfoDelete(@RequestParam("pet_Id") String pet_Id, @RequestParam("owner_Id") String owner_Id,
                                RedirectAttributes rttr, HttpServletRequest request){
        System.out.println("owner_Id = " + owner_Id);
            ps.petInfoDelete(pet_Id);
        rttr.addAttribute("ownerId", owner_Id);
        ps.getPetInfo(owner_Id);
        return "redirect:/pet/info";
    }
}
