package com.review.controller.animal;

import com.review.dto.animal.AnimalAdoptionDTO;
import com.review.dto.animal.AnimalMemberDTO;
import com.review.repository.animal.FileRepository;
import com.review.service.animal.AnimalAdoptionService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AnimalAdoptionController {

    @Setter(onMethod_ = @Autowired)
    private AnimalAdoptionService adoptionService;

    /**********************************************  입양 동물 등록  ************************************************/
    @GetMapping("/adoption/animal/register")
    public String adoptionAnimalRegister(HttpServletRequest request, RedirectAttributes rttr){
        HttpSession session = request.getSession();
        AnimalMemberDTO loginId =(AnimalMemberDTO) session.getAttribute("loginId");

        if (loginId.getGrade() == 99){
            return "/animal/adoption/register";

        } else {
            rttr.addAttribute("grade", "권한이 없습니다.");
            return "redirect:/";
        }

    }

    @PostMapping("/adoption/animal/register")
    public String adoptionAnimalRegister(AnimalAdoptionDTO adoptionDTO,
                                         @RequestParam("thumbnails") List<MultipartFile> thumbnails,
                                         @RequestParam("files") List<MultipartFile> files) throws IOException {

        adoptionService.adoptionAnimalRegister(adoptionDTO, thumbnails, files);
        System.out.println("thumbnails = " + thumbnails);
        System.out.println("files = " + files);

        return "redirect:/adoption/animal/list";
    }

    /**********************************************  입양 동물 목록  ************************************************/
    @GetMapping("/adoption/animal/list")
    public String adoptionAnimalList(Model model){

            List<AnimalAdoptionDTO> adoptionAnimalList = adoptionService.adoptionAnimalList();
            model.addAttribute("list", adoptionAnimalList);
            return "/animal/adoption/list";
    }


    /********************************************  입양 동물 상세보기  ************************************************/
    @GetMapping("/adoption/animal/read")
    public String adoptionAnimalRead(AnimalAdoptionDTO adoptionDTO, Model model){

            AnimalAdoptionDTO adoptionAnimalRead = adoptionService.adoptionAnimalRead(adoptionDTO);
            model.addAttribute("read", adoptionAnimalRead);
            return "/animal/adoption/read";


    }

    /********************************************  입양 동물 수정  ************************************************/
    @GetMapping("/adoption/animal/information/modify")
    public String adoptionAnimalInformationModify(AnimalAdoptionDTO adoptionDTO, Model model,
                                                  HttpServletRequest request, RedirectAttributes rttr){
        HttpSession session = request.getSession();
        AnimalMemberDTO loginId = (AnimalMemberDTO) session.getAttribute("loginId");

        if (loginId.getGrade() == 99) {
            AnimalAdoptionDTO adoptionAnimalRead = adoptionService.adoptionAnimalRead(adoptionDTO);
            model.addAttribute("modify", adoptionAnimalRead);
            return "/animal/adoption/modify";
        }else {
            rttr.addAttribute("grade", "권한이 없습니다.");
            return "redirect:/";
        }
    }

    @PostMapping("/adoption/animal/information/modify")
    public String adoptionAnimalInformationModify(AnimalAdoptionDTO adoptionDTO, RedirectAttributes rttr, HttpServletRequest request){

        adoptionService.adoptionAnimalInformationModify(adoptionDTO);
        rttr.addAttribute("adoption_id", request.getParameter("adoption_id"));

        return "redirect:/adoption/animal/read";
    }
}
