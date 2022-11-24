package com.gdu.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GalleryController {
	
	@GetMapping("/gallery/list")
	public String list() {
		return "gallery/list";
	}
	
	@GetMapping("galley/detail")
	public String detail() {
		return "gallery/detail";
	}
}
