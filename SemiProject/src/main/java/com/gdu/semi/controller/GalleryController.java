package com.gdu.semi.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.semi.service.GalleryService;

@Controller
public class GalleryController {
	
	@Autowired
	private GalleryService galleryService;
	
	@GetMapping("/gallery/list")
	public String list(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		galleryService.getGalleryList(request, model);
		return "gallery/list";
	}
	
	@GetMapping("galley/detail")
	public String detail() {
		return "gallery/detail";
	}
	
	@PostMapping(value="/gallery/write")
	public String write() {
		return "gallery/write";
	}
	
	@PostMapping("/gallery/add")
	public void insertGallery(HttpServletRequest request, HttpServletResponse response) {
		galleryService.addGallery(request, response);
	}
	
	@GetMapping("/gallery/increse/hit")
	public String increseHit(@RequestParam (value="galNo", required=false, defaultValue="0") int galNo) {
		int result = galleryService.increseGalleryHit(galNo);
		if (result > 0) {	// 조회수 증가에 성공하면 상세보기로 이동
			return "redirect:/gallery/detail?galNo=" + galNo;
		} else {
			return "redirect:/gallery/list";
		}
	}
	
	@GetMapping("/gallery/detail")
	public String detail(@RequestParam (value="galNo", required=false, defaultValue="0") int galNo, Model model) {
		model.addAttribute("gallery", galleryService.getGalleryByNo(galNo));
		return "gallery/detail";
	}
	
	@PostMapping("/gallery/edit")
	public String edit(int galNo, Model model) {
		model.addAttribute("gallery", galleryService.getGalleryByNo(galNo));
		return "gallery/edit";
	}
	
	@PostMapping("/gallery/modify")
	public String modify(HttpServletRequest request, HttpServletResponse response) {
		galleryService.modifyGallery(request, response);	// 수정 후 상세보기로
		return "redirect:/gallery/detail?galNo=" + request.getParameter("galNo");
	}
	
	@PostMapping("/gallery/remove")
	public String remove(HttpServletRequest request, HttpServletResponse response) {
		galleryService.removeGallery(request, response);	// 수정 후 상세보기로
		return "redirect:/gallery/list";
	}
	
}
