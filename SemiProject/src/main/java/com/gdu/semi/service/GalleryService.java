package com.gdu.semi.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi.domain.GalleryDTO;

public interface GalleryService {
	public void getGalleryList(HttpServletRequest request, Model model);
	public void findGalleryList(HttpServletRequest request, Model model);
	public Map<String, Object> checkAttachedImage(int galNo);
	
	// 1. 갤러리 작성
	public void addGallery(HttpServletRequest request, HttpServletResponse response);
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest);
	
	// 2. 상세보기, 조회수
	public int increseGalleryHit(int galNo);
	public GalleryDTO getGalleryByNo(int galNo);
	
	// 3. 수정
	public void modifyGallery(HttpServletRequest request, HttpServletResponse response);
	
	// 4. 좋아요
	public Map<String, Object> getLikeCount(HttpServletRequest request);
	public int getLikeUser(HttpServletRequest request);
	public int touchLike(HttpServletRequest request);
	
	// 5. 삭제
	public void removeGallery(HttpServletRequest request, HttpServletResponse response);
}
