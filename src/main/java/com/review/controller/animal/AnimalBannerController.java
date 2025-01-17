package com.review.controller.animal;

import com.review.dto.animal.AnimalBannerDTO;
import com.review.dto.animal.AnimalMemberDTO;
import com.review.service.animal.AnimalBannerService;
import com.review.service.animal.AnimalMedicalReviewService;
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
public class AnimalBannerController {

    @Setter(onMethod_ = @Autowired)
    private AnimalBannerService bannerService;

    @Setter(onMethod_ = @Autowired)
    private AnimalMedicalReviewService reviewService;


    /********************************************  배너 등록  ************************************************/
    @GetMapping("/banner/register")
    public String bannerRegister(HttpServletRequest request, RedirectAttributes rttr) {
        HttpSession session = request.getSession();
        AnimalMemberDTO loginId = (AnimalMemberDTO) session.getAttribute("loginId");

        if (loginId.getGrade() == 99) {
            return "/animal/banner/bannerRegister";
        }else {
            rttr.addAttribute("grade", "권한이 없습니다.");
            return "redirect:/";
        }
    }

    @PostMapping("/banner/register")
    public String bannerRegister(AnimalBannerDTO bannerDTO, List<MultipartFile> file, @RequestParam("folderNm")String folderNm) throws IOException {

        bannerService.bannerRegister(bannerDTO, file,folderNm);
        return "redirect:/banner/list";
    }

    /********************************************  등록된 배너 목록  ************************************************/
    @GetMapping("/banner/list")
    public String bannerList(Model model, HttpServletRequest request, RedirectAttributes rttr){
        HttpSession session = request.getSession();
        AnimalMemberDTO loginId = (AnimalMemberDTO) session.getAttribute("loginId");

        if (loginId.getGrade() == 99) {
            List<AnimalBannerDTO> bannerList = bannerService.bannerList();
            model.addAttribute("list", bannerList);

            return "/animal/banner/bannerList";
        }else {
            rttr.addAttribute("grade", "권한이 없습니다.");
            return "redirect:/";
        }
    }


    /********************************************  등록된 배너 수정  ************************************************/
    @GetMapping("/banner/modify")
    public String bannerRead(AnimalBannerDTO bannerDTO, Model model,
                             HttpServletRequest request, RedirectAttributes rttr){


        HttpSession session = request.getSession();
        AnimalMemberDTO loginId = (AnimalMemberDTO) session.getAttribute("loginId");

        if (loginId.getGrade() == 99) {
            List<Map<String, Object>> fileList = reviewService.selectFileList(bannerDTO.getBanner_id());

            AnimalBannerDTO bannerRead = bannerService.bannerRead(bannerDTO);
            model.addAttribute("banner", bannerRead);
            model.addAttribute("file", fileList);
            return "/animal/banner/bannerModify";
        }else {
            rttr.addAttribute("grade", "권한이 없습니다.");
            return "redirect:/";
        }
    }

    @PostMapping("/banner/modify")
    public String bannerModify(AnimalBannerDTO bannerDTO,  List<MultipartFile> file, @RequestParam("folderNm")String folderNm) throws IOException {
        System.out.println("####bannerDTO = " + bannerDTO);
        bannerService.bannerModify(bannerDTO, file, folderNm);

        return"redirect:/banner/list";
    }

}
