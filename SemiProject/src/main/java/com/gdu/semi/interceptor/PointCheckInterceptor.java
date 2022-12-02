package com.gdu.semi.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.gdu.semi.domain.UserDTO;
import com.gdu.semi.mapper.UploadMapper;

@Component
public class PointCheckInterceptor implements HandlerInterceptor {
	
	@Autowired
	UploadMapper uploadMapper;
	
	// # 포인트 체크 인터셉터
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 1. 유저의 아이디 가져오기
		
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO)session.getAttribute("loginUser");
		
		String id = user.getId();
		System.out.println(id);
		// 2. id로 유저의 포인트 조회
		int point = uploadMapper.selectUserPoint(id);
		
		
		// 3. 포인트 비교
		if(point < 5 || point == 0) {
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('포인트가 부족합니다');");
			out.println("history.back();");
			out.println("</script>");
			return false;
		}
		
		return true;
	}

}
