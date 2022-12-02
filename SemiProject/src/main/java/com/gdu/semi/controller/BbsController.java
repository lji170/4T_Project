package com.gdu.semi.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.semi.service.BbsService;

@Controller
public class BbsController {

	@Autowired
	private BbsService bbsService;

	@GetMapping("/bbs/list")
	public String list(HttpServletRequest request, Model model) {
		bbsService.findAllBbsList(request, model);
		return "bbs/list";
	}
	
	@GetMapping("/bbs/write")
	public String write() {
		return "bbs/write";
	}
	
	@PostMapping("/bbs/add")
	public String add(HttpServletRequest request) {
		bbsService.addBbs(request);
		return "redirect:/bbs/list";
	}
	
	@PostMapping("/bbs/remove")
	public String remove(@RequestParam("bbsNo") int bbsNo) {
		bbsService.removeBbs(bbsNo);
		return "redirect:/bbs/list";
	}
	
	@PostMapping("/bbs/reply/add")
	public String replyAdd(HttpServletRequest request) {
		bbsService.addReply(request);
		return "redirect:/bbs/list";
		
	}
	@GetMapping("/bbs/modify")
	public String modify(HttpServletRequest request) {
		return "bbs/edit";
	}
	
	@GetMapping("/bbs/edit")
	public String edit(HttpServletRequest request) {
		bbsService.modifyBbs(request);
		return "redirect:/bbs/list";
	}
	
	
	
}