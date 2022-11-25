package com.gdu.semi.service;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

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
	public void getGalleryList(HttpServletRequest request, Model model) {
		
		// 파라미터
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		Optional<String> rppOpt = Optional.ofNullable(request.getParameter("recordPerPage"));
		int recordPerPage = Integer.parseInt(rppOpt.orElse("10"));
		
		// 전체 블로그 개수
		int totalRecord = galleryMapper.selectGalleryListCount();
		
		// 페이징 처리에 필요한 변수 선언
		pageUtil.setPageUtil(page, recordPerPage, totalRecord);
		
		// 조회 조건으로 사용할 Map 만들기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		// 뷰로 전달할 데이터를 model에 저장하기
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("galleryList", galleryMapper.selectGalleryListByMap(map));
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/gallery/list"));
		galleryMapper.selectGalleryList();
	
	}
	
	@Override
	public void addGallery(HttpServletRequest request, HttpServletResponse response) {
		String id = "인절미";
		String galTitle = request.getParameter("galTitle");
		String galContent = request.getParameter("galContent");
		Optional<String> opt = Optional.ofNullable(request.getHeader("X-Fowarded-For"));
		String ip = opt.orElse(request.getRemoteAddr());
		
		GalleryDTO gallery = GalleryDTO.builder()
				.id(id)
				.galTitle(galTitle)
				.galContent(galContent)
				.ip(ip)
				.build();
		
		// DB에 저장
		int result = galleryMapper.insertGallery(gallery);
		
		// 응답
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if (result > 0) {
				out.println("alert('갤러리 삽입 성공');");
				out.println("location.href='"+ request.getContextPath() +"/gallery/list';");
			} else {
				out.println("alert('갤러리 삽입 실패');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest) {
		return null;
	}
	
	@Override
	public int increseGalleryHit(int galNo) {
		return galleryMapper.updateHit(galNo);
	}
	
	@Override
	public GalleryDTO getGalleryByNo(int galNo) {
		return galleryMapper.selectGalleryByNo(galNo);
	}
	
	@Override
	public void modifyGallery(HttpServletRequest request, HttpServletResponse response) {
		// 파라미터
		int galNo = Integer.parseInt(request.getParameter("galNo"));
		String galTitle = request.getParameter("galTitle");
		String galContent = request.getParameter("galContent");
		
		GalleryDTO gallery = GalleryDTO.builder()
				.galNo(galNo)
				.galTitle(galTitle)
				.galContent(galContent)
				.build();
		galleryMapper.updateGallery(gallery);
		
	}
	
	@Override
	public void removeGallery(HttpServletRequest request, HttpServletResponse response) {
		int galNo = Integer.parseInt(request.getParameter("galNo"));
		galleryMapper.deleteGallery(galNo);
		
	}
}
