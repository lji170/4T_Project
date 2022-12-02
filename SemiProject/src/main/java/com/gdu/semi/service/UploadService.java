package com.gdu.semi.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface UploadService {
	
	// # 게시글 목록
		public void getUploadList(HttpServletRequest request, Model model);
		
		// # 게시글 상세
		public void getUploadByNo(HttpServletRequest request, Model model);
		
		// # 게시글 추가
		public void addRead(MultipartHttpServletRequest multipartServletRequest, HttpServletResponse response);

		// # 첨부 개별 다운로드
		public ResponseEntity<Resource> download(String agent, HttpServletRequest request);
		
		// # 첨부 전체 다운로드
		public ResponseEntity<Resource> downloadAll(String agent, HttpServletRequest request);
		
		// # 게시글 수정
		public void modifyUpload (MultipartHttpServletRequest multipartRequest, HttpServletResponse response);
		
		// # 첨부파일 삭제
		public void removeAttach(int attachNo);
		
		// # 첨부파일 전부 삭제
		public void removeAttachAll(int uploadNo);
		
		// # 게시글 삭제
		public void removeUpload(HttpServletRequest request, HttpServletResponse response);
		
		// # 검색 조회
		public void selectUploadSearch(HttpServletRequest request, Model model);
	
}
