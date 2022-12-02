package com.gdu.semi.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.semi.service.UploadService;

@Controller
public class UploadController {
	
	@Autowired
	UploadService uploadService;
	
	
	// # service + move : 목록페이지
	// - 매개변수 
	// (1) request( 용도 : 페이지 이동을 위한 page 파라미터 전달)
	// (2) model : 페이징 처리
	@GetMapping("/upload/list")
	public String uploadList(HttpServletRequest request, Model model) {
		uploadService.getUploadList(request, model);
		return "upload/list";
	}
	
	// # 상세
	@GetMapping("/upload/detail")
	public String detail(HttpServletRequest request, Model model)  {
		uploadService.getUploadByNo(request, model);
		return "upload/detail";
	}
	
	// # 추가
	// 1) move : 추가창(AOP: 로그인 한 경우에만 작성창 이동가능)
	@GetMapping("/upload/write")
	public String requiredLogin_write() {
		return "upload/write";
	}
	
	// 2) service
	@PostMapping("/upload/add")
	public void add(MultipartHttpServletRequest multipartServletRequest, HttpServletResponse response) {
		uploadService.addRead(multipartServletRequest, response);
	}
	
	// # 다운로드
	// * 다운로드시, @responsebody, responseentity 객체 사용
	// - 장점 : ajax없이도 사용할 수 있으며, ajax처럼 페이지 변화없이 다운로드가 가능해진다
	
	// 1) 개별다운로드
	// * @RequestHeader("User-agent") String agent : 브라우저에 따른 한글깨짐을 처리하기 위해 사용
	// - 기능 : 해당 브라우저가 뭔지 등 디바이스의 정보를 얻을 수 있다
	@ResponseBody
	@GetMapping("/upload/download")
	public ResponseEntity<Resource> download(@RequestHeader("User-agent") String agent, 
													HttpServletRequest request) {
		return uploadService.download(agent, request);
	}
	
	// 2) 전체 다운로드
	@ResponseBody
	@GetMapping("/upload/downloadAll")
	public ResponseEntity<Resource> downloadAll(@RequestHeader("User-agent") String agent, 
													HttpServletRequest request) {
		return uploadService.downloadAll(agent, request);
	}
	
	
	// # 수정
	// 1) 편집창 이동 : 수정은 편집창도 post요청을 해야한다(본인만 수정할 수 있어야하니까) 
	// AOP: 로그인 한 경우에만 작성창 이동가능
	// & 수정 : 원래 post 처리였으나, 첨부삭제후 post 요청을 못받아서 edit으로 처리
	@PostMapping("/upload/edit")
	public String edit(HttpServletRequest request,  Model model) {
		uploadService.getUploadByNo(request, model);	// 특정 uploadNo의 upload, attach 테이블 둘다 조회
		return "upload/edit";
	}
	
	// 2) 수정요청 
	@PostMapping("/upload/modify")
	public void modify (MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		uploadService.modifyUpload(multipartRequest, response);
	}
	
	// # 삭제
	
	// 1) 첨부파일 삭제	
	// * uploadNo가 필요한 이유 : 첨부파일 삭제후 특정 게시글의 edit창으로 다시 돌아가기 위해서 
	// & 문제발생 : 첨부파일 삭제후, 리다이렉트 경로로 edit창으로 돌아가고싶다
	// - 해결 : 화면전환 없이 해결해야하니 ajax로 처리해야한다
	// ajax 없이 해결하는건 잘못된 방법이다(일단 불가능)
	@PostMapping("/attach/remove")
	public String attachRemove(@RequestParam("attachNo") int attachNo,
							@RequestParam("uploadNo") int uploadNo,
							RedirectAttributes redirectAttributes) {
		uploadService.removeAttach(attachNo);
		
		return "redirect:/upload/detail?uploadNo=" + uploadNo;
	}
	
	// 2) 첨부파일 전체 삭제
	@PostMapping("/attach/removeAll")
	public String attachRemoveAll(@RequestParam("attachNo") int attachNo,
							@RequestParam("uploadNo") int uploadNo,
							RedirectAttributes redirectAttributes) {
		uploadService.removeAttachAll(uploadNo);
		
		return "redirect:/upload/detail?uploadNo=" + uploadNo;
	}
	
	// 3) 게시글 삭제
	@PostMapping("/upload/remove")
	public void uploadRemove(HttpServletRequest request, HttpServletResponse response) {
		uploadService.removeUpload(request, response);
	}
	
	
	// # 검색어에 따른 목록 검색
	@GetMapping("/upload/Search")
	public String uploadSearch(HttpServletRequest request, Model model) {
		uploadService.selectUploadSearch(request, model);
		return "upload/list";
	}
	
	// # 로그아웃
		@GetMapping("upload/logout")
		public String uploadLogout(HttpServletRequest request, Model model) {
			// * session에 올려둔 id값 없애고 목록 리다이렉트
			// 실제로는 목록에서 추가한 임시계정이 없으니 문제없이 작동할듯
			HttpSession session = request.getSession();
			session.removeAttribute("loginUser");
			return "redirect:/upload/list";
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
