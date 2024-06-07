package com.review.interceptor;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.service.animal.OwnerService;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@Log4j2
public class RememberMeInterceptor extends HandlerInterceptorAdapter {

    @Setter(onMethod_ = @Autowired)
    private OwnerService ownerService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception{


        HttpSession session = request.getSession();
        Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
        if (loginCookie != null){
            AnimalMemberDTO animalDTO = ownerService.checkLoginBefore(loginCookie.getValue());
            if (animalDTO != null){
                session.setAttribute("loginId", animalDTO);
            }
        }
        return true;
    }
}
