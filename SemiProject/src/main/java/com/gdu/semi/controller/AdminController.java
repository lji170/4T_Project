package com.gdu.semi.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.semi.domain.UserDTO;
import com.gdu.semi.service.AdminService;
import com.gdu.semi.util.SecurityUtil;

@Controller
public class AdminController {
	
	@Autowired 
	private AdminService adminService;
	
	@Autowired
	private SecurityUtil securityUtil;
	
	@GetMapping("/admin/main")
	public String adminMain() {
		return "admin/main";
	}
	
	@ResponseBody
	@GetMapping(value="/admin/userList", produces="application/json; charset=UTF-8")
	public Map<String, Object> userList(HttpServletRequest request, Model model) {
		
		return adminService.getUserList(request, model);
	}
	
	@GetMapping("/admin/userDetail")
	public String userDetail(@RequestParam(value="userNo", required=false, defaultValue="0") int userNo, Model model) {
		model.addAttribute("user", adminService.getUserNo(userNo));
		return "admin/user/detail";
	}
	@GetMapping("/admin/userRemove")
	public String removeUser(HttpServletRequest request) {
		adminService.removeUserByNo(request);
		return "admin/main";
	}
	
}
