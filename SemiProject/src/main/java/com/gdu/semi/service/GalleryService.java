package com.gdu.semi.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi.domain.GalleryDTO;

public interface GalleryService {
	public void getGalleryList(HttpServletRequest request, Model model);
	public void addGallery(HttpServletRequest request, HttpServletResponse response);
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest);
	public int increseGalleryHit(int galNo);
	public GalleryDTO getGalleryByNo(int galNo);
	public void modifyGallery(HttpServletRequest request, HttpServletResponse response);
	public void removeGallery(HttpServletRequest request, HttpServletResponse response);
}
