package com.gdu.semi.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi.service.GalleryService;

@Controller
public class GalleryController {
	
	@Autowired
	private GalleryService galleryService;
	
	// 목록 개수
	@GetMapping("/gallery/change/list")
	public String changeList(HttpServletRequest request, int recordPerPage) {
		// 세션에 recordPerPage를 변경해서 올린 뒤 다시 목록으로 돌아감
		request.getSession().setAttribute("recordPerPage", recordPerPage);
		return "redirect:" + request.getHeader("referer");
	}
	// 목록 뿌리기
	@GetMapping("/gallery/list")
	public String list(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		galleryService.getGalleryList(request, model);
		return "gallery/list";
	}
	@ResponseBody
	@GetMapping("/gallery/attachedImage")
	public Map<String, Object> attachedImage(int galNo){
		return galleryService.checkAttachedImage(galNo);
	}
	// 검색
	@GetMapping("/gallery/search")
	public String search(HttpServletRequest request, Model model) {
		galleryService.findGalleryList(request, model);
		return "gallery/list";
	}

	@PostMapping(value="/gallery/write")
	public String write() {
		return "gallery/write";
	}
	
	@PostMapping("/gallery/add")
	public void insertGallery(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		galleryService.addGallery(request, response);
	}
	
	@ResponseBody
	@PostMapping(value="/gallery/uploadImage", produces="application/json")
	public Map<String, Object> uploadImage(MultipartHttpServletRequest multipartRequest) {
		return galleryService.saveSummernoteImage(multipartRequest);
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
	
	// 좋아요
	@ResponseBody
	@GetMapping("gallery/likeCount")
	public Map<String, Object> likeCount(HttpServletRequest request) {
		return galleryService.getLikeCount(request);
	}
	@ResponseBody
	@GetMapping("/gallery/likeUser")
	public int likeUser(HttpServletRequest request) {
		return galleryService.getLikeUser(request);
	}
	@ResponseBody
	@GetMapping(value="/gallery/touchLike")
	public int touchLike (HttpServletRequest request) {
		return galleryService.touchLike(request);
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
