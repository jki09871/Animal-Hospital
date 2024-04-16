package com.review.controller;

import com.review.service.KaKaoService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@Controller
@Log4j
@RequiredArgsConstructor
@RequestMapping("/member/*")
public class KaKaoController {

    @Setter(onMethod_ = @Autowired)
    KaKaoService ks;

    @GetMapping("/do")
    public String loginPage(Model model) {

        return "kakaoCI/login";
    }

    @GetMapping("/kakao")
    public String getCI(@RequestParam String code, Model model, HttpSession session) throws IOException {

        String access_token = ks.getToken(code);
        Map<String, Object> userInfo = ks.getUserInfo(access_token);
        model.addAttribute("code", code);
        model.addAttribute("access_token", userInfo.get("access_token"));
        model.addAttribute("id", userInfo.get("id"));

        if (userInfo.get("id") != null) {
            session.setAttribute("userId", userInfo.get("id"));
            session.setAttribute("access_token", userInfo.get("access_token"));
        }
        // ci는 비즈니스 전환후 검수신청 -> 허락받아야 수집가능
        return "kakaoCI/logincode";

    }

    @RequestMapping(value="/logout")
    public String logout(HttpSession session) {
        String access_token = (String)session.getAttribute("access_token");


        if(access_token != null && !"".equals(access_token)){
            ks.kakaoLogout(access_token);
            session.invalidate();
        }else{
            System.out.println("access_Token is null");
        }
        return "redirect:/";
    }
}
