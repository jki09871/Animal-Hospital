package com.review.controller;

import com.review.service.KaKaoService;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
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
    public String getCI(@RequestParam String code, Model model) throws IOException {

        System.out.println("code = " + code);
        String access_token = ks.getToken(code);
        System.out.println("access_token = " + access_token);
        Map<String, Object> userInfo = ks.getUserInfo(access_token);
        model.addAttribute("code", code);
        model.addAttribute("access_token", userInfo.get("access_token"));
        model.addAttribute("userInfo", userInfo);


        // ci는 비즈니스 전환후 검수신청 -> 허락받아야 수집가능
        return "kakaoCI/logincode";

    }

    @RequestMapping(value="/kakaologout")
    public String logout(HttpSession session) {
        ks.logout((String)session.getAttribute("access_token"));
        session.invalidate();
        return "redirect:/";
    }
}
