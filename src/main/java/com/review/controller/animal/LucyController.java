//package com.review.controller.animal;
//
//import com.nhncorp.lucy.security.xss.XssPreventer;
//import lombok.AllArgsConstructor;
//import lombok.extern.log4j.Log4j;
//import org.json.simple.JSONObject;
//import org.json.simple.JSONValue;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.servlet.ModelAndView;
//
//import javax.servlet.http.HttpServletRequest;
//
//@Log4j
//@Controller
//@AllArgsConstructor
//public class LucyController {
//
//    @GetMapping("/xss/useFilter.do")
//    public String useFilter(){
//        return "Lucy-xss-servlet-filter/ex01";
//    }
//
//    @RequestMapping(value = "/xss/useFilter.do", method = { RequestMethod.POST })
//    public ModelAndView useFilter(HttpServletRequest request) throws Exception {
//        ModelAndView mav = new ModelAndView();
//
//        String inputMsg   = request.getParameter("inputMsg");
//        String convertMsg = XssPreventer.unescape(inputMsg);
//
//        System.out.println("### Get Message(Use XSS Filter) ###");
//        System.out.println("### 치환 => " + inputMsg);
//        System.out.println("### 역치환 => " + convertMsg);
//
//        mav.addObject("msg", inputMsg);
//        mav.setViewName("Lucy-xss-servlet-filter/message");
//
//        return mav;
//    }
//
//    @RequestMapping(value = "/xss/noneFilter.do", method = { RequestMethod.POST })
//    public ModelAndView noneFilter(HttpServletRequest request) throws Exception {
//        ModelAndView mav = new ModelAndView();
//
//        String inputMsg   = request.getParameter("inputMsg");
//
//        System.out.println("### Get Message(None XSS Filter) ###");
//        System.out.println("### => " + inputMsg);
//
//        mav.addObject("msg", inputMsg);
//        mav.setViewName("Lucy-xss-servlet-filter/message");
//
//        return mav;
//    }
//
//    @GetMapping
//    @RequestMapping("/xss/globalFilter.do")
//    public ModelAndView globalFilter(HttpServletRequest request) throws Exception{
//        ModelAndView mav = new ModelAndView();
//
//        String nParam = request.getParameter("nParam");
//        String nMsg = request.getParameter("nMsg");
//        String msg = request.getParameter("msg");
//
//        System.out.println("### Get Message(<global> 태그 사용) ###");
//        System.out.println("### nParam => " + nParam);
//        System.out.println("### nMsg => " + nMsg);
//        System.out.println("### msg => " + msg);
//
//        mav.addObject("nParam", nParam);
//        mav.addObject("nMsg"  , nMsg);
//        mav.addObject("msg"   , msg);
//        mav.setViewName("Lucy-xss-servlet-filter/ex02");
//
//
//        return mav;
//    }
//
//    @GetMapping("/xss/jsonFilter")
//    public String asd(){
//        return "Lucy-xss-servlet-filter/ex03";
//    }
//
//    @RequestMapping(value = "/xss/jsonFilter.do", method = { RequestMethod.POST})
//    public @ResponseBody JSONObject sqlExceptionPost(@RequestBody String jsonParam) throws Exception {
//        JSONObject result = new JSONObject();
//
//        JSONObject json = (JSONObject) JSONValue.parse(jsonParam);
//
//        String msg = (String) json.get("msg");
//
//        System.out.println("### Get Message(JSON 데이터) ###");
//        System.out.println("### => " + msg);
//
//        result.put("msg", msg);
//
//        return result;
//    }
//}
