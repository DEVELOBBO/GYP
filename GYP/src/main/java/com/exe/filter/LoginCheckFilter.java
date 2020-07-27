package com.exe.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.exe.dto.CustomInfo;

public class LoginCheckFilter implements Filter {
	
	//필터가 생성되면서 실행될 메소드
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("LoginCheckFilter is created!!");
	}

	//호출마다 실행될 메소드
	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
        String requestURI = request.getRequestURI();
        CustomInfo dto = null;
        dto = (CustomInfo) request.getSession().getAttribute("customInfo");
        System.out.println(requestURI);
        System.out.println(dto);
        //특정 조건 로그인 필터
        if(dto!=null) {
        	if(dto.getLoginType().equals("customer")) {
        		if(false){
                    //요청 URI가 /gyp/customerUpdate_ok 혹은 /gyp/customerDeleted_ok가 아닐 때
        			return;
                }
        	}else if(dto.getLoginType().equals("gym")) {
        		if(requestURI.equals("/gyp/gymJjim")){
        			response.sendRedirect("/gymMyPage");
        			return;
                }
        	}else if(dto.getSessionId().equals("admin")) {
        		if(false){
                    //요청 URI가 /gyp/customerUpdate_ok 혹은 /gyp/customerDeleted_ok가 아닐 때
        			return;
                }
        	}
        //전체 필터
        }else if(requestURI.equals("/gyp/faceLink.action")) {
        	System.out.println("전체필터 작동");
        	response.sendRedirect("/gyp/login.action");
        	return;
        }
       
        chain.doFilter(req, resp);
       
	}

	//필터가 소멸하면서 실행될 메소드
	@Override
	public void destroy() {
		System.out.println("LoginCheckFilter is destroyed!!");
	}

}
