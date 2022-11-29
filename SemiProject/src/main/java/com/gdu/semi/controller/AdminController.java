package com.gdu.semi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public Map<String, Object> userList(HttpServletRequest request) {
		
		return adminService.getUserList(request);
	}
	
	@ResponseBody
	@GetMapping(value="/admin/searchUser", produces="application/json; charset=UTF-8")
	public Map<String, Object> findUserList(HttpServletRequest request){
		return adminService.findUser(request);
	}
	@ResponseBody
	@PostMapping(value="/admin/retireUser", produces="application/json; charset=UTF-8")
	public Map<String, Object> checkTestSave(@RequestParam(value="userNo") String[] userNo, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<>();
		for(String s : userNo) {
			map.put("map", adminService.removeUser(s, request, response)) ;
		}
		return map;
		
		
		
		
	}
}
