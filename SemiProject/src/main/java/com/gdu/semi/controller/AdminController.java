package com.gdu.semi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	
	@PostMapping("/admin/main")
	public String adminMain() {
		return "admin/main";
	}
	
	@ResponseBody
	@PostMapping(value="/admin/userList", produces="application/json; charset=UTF-8")
	public Map<String, Object> userList(HttpServletRequest request) {
		
		return adminService.getUserList(request);
	}
	
	@ResponseBody
	@PostMapping(value="/admin/searchUser", produces="application/json; charset=UTF-8")
	public Map<String, Object> findUserList(HttpServletRequest request){
		return adminService.findUser(request);
	}
	
	@ResponseBody
	@PostMapping(value="/admin/retireUser", produces="application/json; charset=UTF-8")
	public Map<String, Object> TranslationRetire(@RequestParam(value="userNo[]") List<String> userNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		return adminService.removeUser(map);
	}
	@ResponseBody
	@PostMapping(value="/admin/sleepUser", produces="application/json; charset=UTF-8")
	public Map<String, Object> TranslationSleep(@RequestParam(value="userNo[]") List<String> userNo) {
		Map<String, Object> map = new HashMap<>();
		map.put("userNo", userNo);
		return adminService.sleepUser(map);
	}
	
	@ResponseBody
	@PostMapping(value="/admin/galleryList", produces="application/json; charset=UTF-8")
	public Map<String, Object> galleryList(HttpServletRequest request){
		return adminService.getGalleryList(request);
	}
	
	
}
