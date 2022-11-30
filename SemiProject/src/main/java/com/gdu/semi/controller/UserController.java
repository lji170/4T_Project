package com.gdu.semi.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.semi.domain.UserDTO;
import com.gdu.semi.service.UserService;

import oracle.jdbc.proxy.annotation.Post;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@GetMapping("/user/agree")	public String agree() {
		return "user/agree";
	}
	
	@GetMapping("/user/join/write")
	public String joinWrite(@RequestParam(required=false) String location
			              , @RequestParam(required = false) String promotion
			              , Model model) {
		model.addAttribute("location", location);
		model.addAttribute("promotion", promotion);
		return "user/join";
	}
	
	@ResponseBody
	@GetMapping(value="/user/checkReduceId", produces=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> checkReduceId(String id){
		return userService.isReduceId(id);
	}
	
	@ResponseBody
	@GetMapping(value="/user/checkReduceEmail", produces=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> checkReduceEmail(String email){
		return userService.isReduceEmail(email);
	}
	
	@ResponseBody
	@GetMapping(value="/user/sendAuthCode", produces=MediaType.APPLICATION_JSON_VALUE)
	public Map<String, Object> sendAuthCode(String email){
		return userService.sendAuthCode(email);
	}
	
	@PostMapping("/user/join")
	public void join(HttpServletRequest request, HttpServletResponse response) {
		userService.join(request, response);
	}
	
	@PostMapping("/user/retire")
	public void retire(HttpServletRequest request, HttpServletResponse response) {
		userService.retire(request, response);
	}
	
	@GetMapping("/index/form")
	public String loginForm(HttpServletRequest request, Model model) {
		
		// 요청 헤더 referer : 이전 페이지의 주소가 저장
		model.addAttribute("url", request.getHeader("referer"));  // 로그인 후 되돌아 갈 주소 url
		
		// 네이버 로그인
		model.addAttribute("apiURL", userService.getNaverLoginApiURL(request));
		
		return "index";
		
	}
	
	@PostMapping("/user/login")
	public void login(HttpServletRequest request, HttpServletResponse response){
		userService.login(request, response);
	}
	
	@GetMapping("/user/naver/login")
	public String naverLogin(HttpServletRequest request, Model model) {
		
		String access_token = userService.getNaverLoginToken(request);
		UserDTO profile = userService.getNaverLoginProfile(access_token);  // 네이버로그인에서 받아온 프로필 정보
		UserDTO naverUser = userService.getNaverUserById(profile.getId()); // 이미 네이버로그인으로 가입한 회원이라면 DB에 정보가 있음
		
		// 네이버로그인으로 가입하려는 회원 : 간편가입페이지로 이동
		if(naverUser == null) {
			model.addAttribute("profile", profile);
			return "user/naver_join";
		}
		// 네이버로그인으로 이미 가입한 회원 : 로그인 처리
		else {
			userService.naverLogin(request, naverUser);
			return "redirect:/";
		}
		
	}
	
	@PostMapping("/user/naver/join")
	public void naverJoin(HttpServletRequest request, HttpServletResponse response) {
		userService.naverJoin(request, response);
	}

	@GetMapping("/user/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		userService.logout(request, response);
		return "redirect:/";
	}
	
	@GetMapping("/user/check/form")
	public String requiredLogin_checkForm() {
		return "user/check";
	}
	
	@ResponseBody
	@PostMapping(value="/user/check/pw", produces="application/json")
	public Map<String, Object> requiredLogin_checkPw(HttpServletRequest request) {
		return userService.confirmPassword(request);
	}
	
	@GetMapping("/user/mypage")
	public String requiredLogin_mypage() {
		return "user/mypage";
	}
	
	@PostMapping("/user/modify/pw")
	public void requiredLogin_modifyPw(HttpServletRequest request, HttpServletResponse response) {
		userService.modifyPassword(request, response);
	}
	
	@GetMapping("/user/sleep/display")
	public String sleepDisplay() {
		return "user/sleep";
	}
	
	@PostMapping("/user/restore")
	public void restore(HttpServletRequest request, HttpServletResponse response) {
		userService.restoreUser(request, response);
	}
	
	
	
	// index페이지로 이동. "/"매핑값을 리다이렉트로 처리했기 때문에 index로 이동하는 매핑 설정
	@GetMapping("/move/index")
	public String moveindex() {
		return "index";
	}
	
	// index.jsp에서 아이디찾기 버튼 클릭시 JSP이동
	@GetMapping("/user/findId")
	public String findId() {
		return "user/findId";
	}
	
	// findId.jsp에서 아이디찾기
	@ResponseBody
	@PostMapping(value="/user/findId/Form", produces="application/json")
	public Map<String, Object> findIdForm(@RequestParam(value="email") String email) {
		return userService.findId(email);
	}
	
	
	@GetMapping("/user/findPw")
	public String findPw() {
		return "user/findPw";
	}
	
	
	@ResponseBody
	@PostMapping(value="/user/sendAuthCodeAndChangePw", produces="application/json")
	public Map<String, Object> sendAuthCodeAndChangePw(){
		
		
	}
	
	
	
	
	
	
	@ResponseBody
	@PostMapping(value="/user/checkReduceIDAndEmail",  produces="application/json")
	public Map<String, Object> checkReduceIDAndEmail(@RequestParam(value="id") String id, @RequestParam(value="email") String email){
	
		return userService.selectIdAndEmail(id,email);
		
	}

	
	
	
	
}
