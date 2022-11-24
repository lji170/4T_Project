package com.gdu.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UploadController {

	
	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	

}