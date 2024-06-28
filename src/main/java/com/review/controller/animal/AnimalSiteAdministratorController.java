package com.review.controller.animal;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.dto.animal.AnimalDTO;
import com.review.paging.PageMakerDTO;
import com.review.paging.PagingCriteria;
import com.review.service.animal.AnimalSiteAdministratorService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Log4j
@Controller
@RequiredArgsConstructor
public class AnimalSiteAdministratorController {
    
    @Setter(onMethod_ = @Autowired)
    private AnimalSiteAdministratorService sa;


    /** 회원가입자 리스트 보기 **/
    @RequestMapping("/subscribers/member")
    public String RegisteredMember(Model model){
        model.addAttribute("memberList",sa.memberList());
        return "/animal/owner/memberSubscriber";
    }

    @GetMapping("/subscribers/look")
    public String memberData(AnimalMemberDTO memberDTO, Model model){

        model.addAttribute("data", sa.memberData(memberDTO));
        return "/animal/owner/memberData";
    }
    @RequestMapping("/registered/animal")
    public String RegisteredAnimal(Model model, PagingCriteria cri){

        model.addAttribute("petList", sa.animalList(cri));
        return "/animal/pet/petSubscriber";
    }

    @RequestMapping("/registered/petNumberSearch")
    public String PetNumberSearch(Model model, PagingCriteria pagingCriteria){

        int total = sa.postTotal(pagingCriteria);
        model.addAttribute("petList", sa.animalList(pagingCriteria));
        model.addAttribute("pageMaker", new PageMakerDTO(pagingCriteria, total));

        return "/animal/pet/petNumberSearch";
    }

    @GetMapping("/registered/look")
    public String petData(AnimalDTO petDTO, Model model){

        model.addAttribute("data", sa.petData(petDTO));
        return "/animal/pet/petData";
    }
}
