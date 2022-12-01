package com.gdu.semi.service;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.semi.domain.GalleryDTO;
import com.gdu.semi.domain.LikeDTO;
import com.gdu.semi.domain.SummernoteImageDTO;
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
	
	@Transactional
	@Override
	public void addGallery(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
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
				// 파라미터 summernoteImageNames
				String[] summernoteImageNames = request.getParameterValues("summernoteImageNames");
				
				// DB에 SummernoteImage 저장
				if(summernoteImageNames !=  null) {
					for(String filesystem : summernoteImageNames) {
						SummernoteImageDTO summernoteImage = SummernoteImageDTO.builder()
								.galNo(gallery.getGalNo())
								.filesystem(filesystem)
								.build();
						galleryMapper.insertSummernoteImage(summernoteImage);
					}
				}
				out.println("alert('갤러리 삽입 성공');");
				
				if (!id.equals("admin")) {
					
				int point = galleryMapper.updateUserPoint(id);
				
				if (point > 0) {
					out.println("alert('포인트를 10점 적립하였습니다.');");
				} else {
					out.println("alert('포인트 적립에 실패했습니다. 게시글 작성이 취소됩니다.');");
				}
				}
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
		// 파라미터 file
		MultipartFile multipartFile = multipartRequest.getFile("file");
		
		// 저장 경로
		String path = "C:" + File.separator + "gallery";
		
		// 저장할 파일명
		String filesystem = myFileUtil.getFilename(multipartFile.getOriginalFilename());
		
		// 저장 경로가 없으면 만들기
		File dir = new File(path);
		if(dir.exists() == false) {
			dir.mkdirs();
		}
		
		// 저장할 File 객체
		File file = new File(path, filesystem);  // new File(dir, filesystem)도 가능
		
		// HDD에 File 객체 저장하기
		try {
			multipartFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 저장된 파일을 확인할 수 있는 매핑을 반환
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("src", multipartRequest.getContextPath() + "/load/image/" + filesystem);  // 이미지 mapping값을 반환
		map.put("filesystem", filesystem);  // HDD에 저장된 파일명 반환
		return map;
		
		// 저장된 파일이 aaa.jpg라고 가정하면
		// src=${contextPath}/load/image/aaa.jpg 이다
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
	
	// 좋아요
	@Override
	public Map<String, Object> getLikeCount(HttpServletRequest request) {
		int galNo = Integer.parseInt(request.getParameter("galNo"));
		Map<String, Object> result = new HashMap<>();
		result.put("likeCount", galleryMapper.selectLikeCount(galNo));
		return result;
	}
	@Override
	public int getLikeUser(HttpServletRequest request) {
		String id = request.getParameter("id");
		int galNo = Integer.parseInt(request.getParameter("galNo"));
		LikeDTO like = LikeDTO.builder()
				.id(id)
				.galNo(galNo)
				.build();
		return galleryMapper.selectLikeUser(like);
	}
	@Override
	public int touchLike(HttpServletRequest request) {
		String id = request.getParameter("id");
		int galNo = Integer.parseInt(request.getParameter("galNo"));
		LikeDTO like = LikeDTO.builder()
				.galNo(galNo)
				.id(id)
				.build();
		
		int result = galleryMapper.selectLikeUser(like);
		System.out.println(result);
		
		if(result == 0) {
			galleryMapper.insertLike(like);
		} else {
			galleryMapper.deleteLike(like);
		}
		
		return result;
	}
	
	
	@Override
	public void removeGallery(HttpServletRequest request, HttpServletResponse response) {
		int galNo = Integer.parseInt(request.getParameter("galNo"));
		galleryMapper.deleteGallery(galNo);
		
	}
}
