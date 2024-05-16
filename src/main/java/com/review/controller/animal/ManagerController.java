package com.review.controller.animal;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.dto.animal.PetDTO;
import com.review.service.animal.ManagerService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Log4j
@Controller
@RequiredArgsConstructor
public class ManagerController {

    @Setter(onMethod_ = @Autowired)
    private ManagerService ms;

    @RequestMapping("/pet/registered/member")
    public String RegisteredMember(Model model){
        model.addAttribute("list",ms.memberList());
        return "/animal/owner/list";
    }

    @RequestMapping("/pet/registered/animal")
    public String RegisteredAnimal(Model model){

        model.addAttribute("list", ms.animalList());
        return "/animal/pet/list";
    }
}
