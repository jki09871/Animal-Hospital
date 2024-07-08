package com.review.controller.animal;

import com.review.dto.animal.AnimalDTO;
import com.review.service.animal.AnimalPetService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalController {

    @Setter(onMethod_ = @Autowired)
    private AnimalPetService ps;

    @RequestMapping("/msg")
    public String msgForward(HttpServletRequest request){

        request.setAttribute("msg", request.getAttribute("msg"));
        request.setAttribute("returnUrl", request.getAttribute("returnUrl"));
        request.setAttribute("method", request.getAttribute("method"));



        return "/msg";
    }

    /************************************************  동물 등록  ************************************************/
    @GetMapping("/pet/info/write")
    public String petInfoWrite(@RequestParam("ownerId") String ownerId, Model model){
        model.addAttribute("ownerId", ownerId);
        log.info("애완동물 정보 쓰기");
        return "/animal/pet/infoWrite";
    }

    @PostMapping("/pet/info/write")
    public String petInfoWrite(AnimalDTO petDTO, RedirectAttributes rttr){

        log.info(petDTO);
        ps.petInfoSave(petDTO);
        ps.getPetInfo(petDTO.getPet_Id());
        rttr.addAttribute("ownerId", petDTO.getOwner_Id());
        return "redirect:/pet/info";
    }
    /************************************************************************************************************/
    /************************************************  등록 정보  ************************************************/

    @GetMapping("/pet/info")
    public String petInfo(@RequestParam ("ownerId") String ownerId , Model model, HttpServletRequest request){
        List<AnimalDTO> petInfo = ps.getPetInfo(ownerId);
        System.out.println("petInfo = " + petInfo);

        if (!petInfo.isEmpty()) {
            model.addAttribute("pet", petInfo);
            return "/animal/pet/info";
        }else {
            String msg = "등록된 동물이 없습니다.";
            request.setAttribute("msg", msg);
            request.setAttribute("returnUrl","/animal/myInfo");
            request.setAttribute("method", "get");
            return "forward:/msg";
        }

    }
    /************************************************************************************************************/

    /************************************************  등록 수정  ************************************************/
    @GetMapping("/pet/info/modify")
    public String petInfoUpdate(@RequestParam ("pet_Id") String pet_Id , Model model, HttpServletRequest request){



        model.addAttribute("pet", ps.petInfoModify(pet_Id));
        return "/animal/pet/infoModify";
    }

    @PostMapping("/pet/info/modify")
    public String petInfoUpdate(AnimalDTO petDTO, RedirectAttributes rttr, @RequestParam("owner_Id") String owner_Id){
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
                                RedirectAttributes rttr){
        System.out.println("owner_Id = " + owner_Id);
            ps.petInfoDelete(pet_Id);
        rttr.addAttribute("ownerId", owner_Id);
        ps.getPetInfo(owner_Id);
        return "redirect:/animal/myInfo";
    }
}
