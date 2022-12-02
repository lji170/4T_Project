package com.gdu.semi.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gdu.semi.domain.SleepUserDTO;
import com.gdu.semi.domain.UserDTO;

public interface UserService {
	
	public Map<String, Object> isReduceId(String id);
	public Map<String, Object> isReduceEmail(String email);
	public Map<String, Object> sendAuthCode(String email);
	public void join(HttpServletRequest request, HttpServletResponse response);
	public void retire(HttpServletRequest request, HttpServletResponse response);
	public void login(HttpServletRequest request, HttpServletResponse response);
	public void keepLogin(HttpServletRequest request, HttpServletResponse response);
	public void logout(HttpServletRequest request, HttpServletResponse response);
	public UserDTO getUserBySessionId(Map<String, Object> map);  // KeepLoginInterceptor에서 호출
	public Map<String, Object> confirmPassword(HttpServletRequest request);
	public void modifyPassword(HttpServletRequest request, HttpServletResponse response);
	public void sleepUserHandle();  // SleepUserScheduler에서 호출
	public SleepUserDTO getSleepUserById(String id);
	public void restoreUser(HttpServletRequest request, HttpServletResponse response);
	
	public String getNaverLoginApiURL(HttpServletRequest request);  // 네이버로그인-1
	public String getNaverLoginToken(HttpServletRequest request);   // 네이버로그인-2
	public UserDTO getNaverLoginProfile(String access_token);       // 네이버로그인-3
	public UserDTO getNaverUserById(String id);
	public void naverLogin(HttpServletRequest request, UserDTO naverUser);
	public void naverJoin(HttpServletRequest request, HttpServletResponse response);
	
	
	//아이디 찾기 
	public Map<String, Object> findId(String email);
	
	// 파라미터로 받은 아이디,이메일이 유저테이블에 있는지 조회함
	 public Map<String, Object> selectIdAndEmail(String id, String email);
	 
	// 인증코드보내고 임시비밀번호로 업데이트
	public Map<String, Object> sendAuthCodeAndChangePw(String id, String email);
	
	// 유저 정보 업데이트하기
	public void updateUserInfo(HttpServletRequest request, HttpServletResponse response);
	
}
