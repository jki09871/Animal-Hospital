package com.review.controller.animal;

import com.review.dto.animal.AnimalAdoptionDTO;
import com.review.service.animal.AnimalAdoptionService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AnimalAdoptionController {

    @Setter(onMethod_ = @Autowired)
    private AnimalAdoptionService adoptionService;

    @GetMapping("/adoption/animal/register")
    public String adoptionAnimalRegister(){

        return "/animal/adoption/register";
    }

    @PostMapping("/adoption/animal/register")
    public String adoptionAnimalRegister(AnimalAdoptionDTO adoptionDTO, MultipartHttpServletRequest mpRequest) throws IOException {
        adoptionService.adoptionAnimalRegister(adoptionDTO, mpRequest);
        return "redirect:/adoption/animal/list";
    }

    @GetMapping("/adoption/animal/list")
    public String adoptionAnimalList(Model model){
        List<AnimalAdoptionDTO> adoptionAnimalList = adoptionService.adoptionAnimalList();
        model.addAttribute("list", adoptionAnimalList);
        return "/animal/adoption/list";
    }

    @GetMapping("/adoption/animal/read")
    public String adoptionAnimalRead(AnimalAdoptionDTO adoptionDTO, Model model){
       AnimalAdoptionDTO adoptionAnimalRead = adoptionService.adoptionAnimalRead(adoptionDTO);
       model.addAttribute("read", adoptionAnimalRead);
       return "/animal/adoption/read";

    }

    @GetMapping("/adoption/animal/information/modify")
    public String adoptionAnimalInformationModify(AnimalAdoptionDTO adoptionDTO, Model model){
        AnimalAdoptionDTO adoptionAnimalRead = adoptionService.adoptionAnimalRead(adoptionDTO);
        model.addAttribute("modify", adoptionAnimalRead);
        return "/animal/adoption/modify";
    }

    @PostMapping("/adoption/animal/information/modify")
    public String adoptionAnimalInformationModify(AnimalAdoptionDTO adoptionDTO, RedirectAttributes rttr, HttpServletRequest request){

        adoptionService.adoptionAnimalInformationModify(adoptionDTO);
        rttr.addAttribute("adoption_id", request.getParameter("adoption_id"));

        return "redirect:/adoption/animal/read";
    }
}
