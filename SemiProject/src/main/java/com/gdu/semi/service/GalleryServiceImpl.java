package com.gdu.semi.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi.domain.GalleryDTO;
import com.gdu.semi.mapper.GalleryMapper;
import com.gdu.semi.util.MyFileUtil;
import com.gdu.semi.util.PageUtil;

@Service
public class GalleryServiceImpl implements GalleryService {

	private GalleryMapper galleryMapper;
	private PageUtil pageUtil;
	private MyFileUtil myFileUtil;
	
	@Autowired
	public void set(GalleryMapper galleryMapper, PageUtil pageUtil, MyFileUtil myFileUtil) {
		this.galleryMapper = galleryMapper;
		this.pageUtil = pageUtil;
		this.myFileUtil = myFileUtil;
	}
	
	@Override
	public void getGalleryList(Model model) {
		

	}
	
	@Override
	public void savegallery(HttpServletRequest request, HttpServletResponse response) {
		
	}
	
	@Override
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest) {
		return null;
	}
	
	@Override
	public int increseGalleryHit(int galNo) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public GalleryDTO getGalleryByNo(int galNo) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void modifyGallery(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void removeGallery(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
	}
}
