package com.gdu.semi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	@PostMapping(value="/userList", produces="application/json; charset=UTF-8")
	public List<UserDTO> userList(Model model) {
		return adminService.getUserList();
	}
}
