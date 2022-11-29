package com.gdu.semi.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.semi.service.CommentService;

@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;
	
	@ResponseBody
	@GetMapping(value="/comment/getCount", produces="application/json")
	public Map<String, Object> getCount (@RequestParam ("galNo") int galNo){
		return commentService.getCommentCount(galNo);
	}
	
	@ResponseBody
	@PostMapping(value="/comment/add", produces="application/json")
	public Map<String, Object> add(HttpServletRequest request){
		return commentService.addComment(request);
	}
	
	@ResponseBody
	@GetMapping(value="/comment/list", produces="application/json")
	public Map<String, Object> list(HttpServletRequest request){
		return commentService.getCommentList(request);
	}
	
	@ResponseBody
	@PostMapping(value="/comment/remove", produces="application/json")
	public Map<String, Object> remove(@RequestParam("commentNo") int commentNo){
		return commentService.removeComment(commentNo);
	}
}
