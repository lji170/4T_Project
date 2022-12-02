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
public class RequiredModifyInterceptor implements HandlerInterceptor {
	
	@Autowired
	UploadMapper uploadMapper;
	
	// # 수정요청 인터셉터 : 작성자 본인만 할 수 있음
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		// 1. session에 저장된 id 가져오기
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO)session.getAttribute("loginUser");
		
		String id = user.getId();
		
		// 2. 게시글 번호
		int uploadNo = Integer.parseInt(request.getParameter("uploadNo")); 
		System.out.println(uploadNo);
		
		// 2. 게시글의 번호 uploadNo를 전달하여 해당 id를 조회
		
		String writer = uploadMapper.selectUserId(uploadNo);
		System.out.println(writer);
		
		// 2. 세션에 저장된 id와 작성자의 id가 동일한지 비교
		if(id.equals(writer) == false) {
			
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('작성자 본인만 수정할 수 있습니다');");
			out.println("history.back();");
			//out.println("location.href='" + request.getContextPath() + "/upload/detail?uploadNo" + uploadNo + "';");
			out.println("</script>");
			
			return false;
		}
		
		// 3. 응답
		
		return true;
	}
	

}
