package com.review.controller.animal;

import com.review.dto.animal.PopUpDTO;
import com.review.service.animal.MedicalReviewService;
import com.review.service.animal.PopUPService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@Log4j2
@Controller
@RequiredArgsConstructor
public class PopUpController {

    @Setter(onMethod_ = @Autowired)
    private PopUPService popUp;

    @Setter(onMethod_ = @Autowired)
    private MedicalReviewService reviewService;
    @GetMapping("/popUp/list")
    public String PopUpList(Model model){
        List<PopUpDTO> popUpDto = popUp.popUpList();

        model.addAttribute("list", popUpDto);
        return "/animal/popup/popUpList";
    }

    @GetMapping("/popup/register")
    public String registerPopUp(){

        return "/animal/popup/register";
    }

    @RequestMapping(value = "/popup/register/post", method = RequestMethod.POST)
    public String registerPopUpPost(PopUpDTO pop, MultipartHttpServletRequest fileRequest) throws Exception {
        // 받아온 데이터를 처리하는 로직을 작성합니다.
        System.out.println("Received PopupDTO: " + pop);



        // 여기서 데이터베이스에 저장하거나 추가적인 비즈니스 로직을 수행할 수 있습니다.
        popUp.popUpRegister(pop, fileRequest);

        // 성공적으로 처리되었다는 메시지를 클라이언트에게 반환합니다.
        return "redirect:/popUp/list";
    }

    @GetMapping("/popup/modify")
    public String popUpModify(PopUpDTO popUpDto, Model model, HttpServletRequest request){
        List<Map<String,Object>> fileList = reviewService.selectFileList(popUpDto.getId());
        PopUpDTO dbDto = popUp.popUpRead(popUpDto);

        System.out.println("fileList = " + fileList);


        model.addAttribute("file", fileList);
        model.addAttribute("popUp", dbDto);
        return "/animal/popup/popUpModify";
    }

    @PostMapping("/popup/modify")
    public String popUpModify(PopUpDTO popUpDto, MultipartHttpServletRequest request) throws IOException {

        popUp.popUpModify(popUpDto, request);
        System.out.println("popUpDto = " + popUpDto);


        return "redirect:/popUp/list";
    }
}
