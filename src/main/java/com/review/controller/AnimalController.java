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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

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
        rttr.addAttribute("ownerId", petDTO.getOwnerId());
        return "redirect:/pet/info";
    }
    /************************************************************************************************************/

    @GetMapping("/pet/info")
    public String petInfo(@RequestParam ("ownerId") String ownerId , Model model){
        model.addAttribute("pet", ps.getPetInfo(ownerId));

        return "/animal/pet/info";
    }

}
