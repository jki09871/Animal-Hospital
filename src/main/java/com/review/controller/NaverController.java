package com.review.controller;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.review.naver.NaverLoginBO;
import lombok.extern.log4j.Log4j;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@Log4j
public class NaverController {

    /*Naver LoginBO*/
    private NaverLoginBO naverLoginBO;
    private String apiResult = null;

    @Autowired
    private void setNaverLoginBO(NaverLoginBO naverLoginBO){
        this.naverLoginBO = naverLoginBO;
    }
//     로그인 첫 화면 요청 메서드

//    @RequestMapping(value = "/member/login", method = {RequestMethod.GET, RequestMethod.POST})
//    public String login(Model model, HttpSession session) {
//
//
//        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
//
//        System.out.println("naverAuthUrl = " + naverAuthUrl);
//
//        //네이버
//        model.addAttribute("url", naverAuthUrl);
//        return "board/list";
//    }

    //네이버 로그인 성공시 callback 호출 메소드
    @RequestMapping(value = "/test/callback", method = {RequestMethod.GET, RequestMethod.POST})
    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
        System.out.println("여기는 callback");
        OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        System.out.println("oauthToken = " + oauthToken);
        System.out.println("session = " + session);
        System.out.println("code = " + code);
        System.out.println("state = " + state);

        //1. 로그인 사용자 정보를 읽어온다
            apiResult = naverLoginBO.getUserProfile(oauthToken); //String 형식의 json 데이터

        /** apiResult json 구조		{"resultcode":"00",
         *  "message":"success",
         *  "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}		**/

        //2. String형식의 apiResult를 json형태로 바꿈
        JSONParser parser = new JSONParser();
        Object obj = parser.parse(apiResult);
        JSONObject jsonObject = (JSONObject) obj;

        //3. 데이터 파싱
        //Top레벨 단계 _response 파싱
        JSONObject response_obj = (JSONObject) jsonObject.get("response");

        System.out.println("response_obj = " + response_obj);
        //response의  nickname값 파싱
        String nickname = (String) response_obj.get("nickname");

        System.out.println("nickname = " + nickname);

        //4. 파싱 닉네임 세션으로 저장
        session.setAttribute("naversessionId", nickname); //세션 생성

        model.addAttribute("result", apiResult);

        return "redirect:/board/list";
    }

    @RequestMapping(value = "/naver/logout", method = {RequestMethod.GET, RequestMethod.POST})
    public String logout(HttpSession session) throws IOException {
        System.out.println("여기는 logout");
        session.invalidate();;


        return "/member/login";
    }
}
