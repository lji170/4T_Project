package com.gdu.semi.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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
}
