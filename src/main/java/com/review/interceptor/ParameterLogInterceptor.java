package com.review.interceptor;

import com.review.controller.HomeController;
import lombok.extern.log4j.Log4j;
import org.apache.logging.log4j.LogManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;

public class ParameterLogInterceptor extends HandlerInterceptorAdapter  {

    //private Logger log = LogManager.getLogger(this.getClass());

    @Override
    public boolean preHandle(// 매개변수 Object는 핸들러 정보를 의미한다.
            HttpServletRequest request, HttpServletResponse response,Object obj) throws Exception {
        
    	if(!(obj instanceof HandlerMethod)) return true;    	
        HandlerMethod method = (HandlerMethod)obj;

        System.out.println("########## LoggerInterceptor 시작  ##########");
        System.out.println(" ");
        System.out.println("#### bean :: " + method.getBean());
        System.out.println("#### method :: " + method.getMethod().getName());
        System.out.println("#### getRequestURI :: " + request.getRequestURI());
        System.out.println("#### getRequestURL :: " + request.getRequestURL());
        System.out.println(" ");
        Enumeration params = request.getParameterNames();
        System.out.println("---------------------------- 파라미터 시작  ----------------------------");
        while (params.hasMoreElements()){
            String name = (String)params.nextElement();
            System.out.println(name + " : " +request.getParameter(name));
        }
        System.out.println("---------------------------- 파라미터 종료  ----------------------------");
        System.out.println(" ");
        System.out.println("########## LoggerInterceptor 종료  ##########");
        
        return true; // 반환이 false라면 controller로 요청을 안함
    }

    // postHandel() 메소드
    // controller의 handler가 끝나면 처리됨
    @Override
    public void postHandle(
            HttpServletRequest request, HttpServletResponse response, Object obj, ModelAndView mav) throws Exception {
    }

    // afterCompletion() 메소드
    // view까지 처리가 끝난 후에 처리됨
    @Override
    public void afterCompletion(
            HttpServletRequest request, HttpServletResponse response,Object obj, Exception e)throws Exception {
    	
    }

}
