package com.gdu.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class indexcontroller {

	
	@GetMapping("/")
	public String index() {
		return "redirect:/index/form";
	}
	
	

}