package com.gdu.semi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.AttachDTO;
import com.gdu.semi.domain.UploadDTO;

@Mapper
public interface UploadMapper {
	
	// # 목록		------------------------------------------------
		// 1) 전체 게시글 수
		public int selectUploadCount();
		
		// 2) 전체 게시글 목록 
		public List<UploadDTO> selectUploadList(Map<String, Object> map);

		
		// # 상세		--------------------------------------------------
		// 1) upload 테이블 상세조회
		public UploadDTO selectUploadByNo(int uploadNo);
		
		// 2) attach 테이블 조건부 전체조회
		public List<AttachDTO> selectAttachList(int uploadNo);
		
		// 3) 조회수 증가
		public int updateHit(int uploadNo);
		
		
		// # 추가	--------------------------------------------------------
		// 1) upload 게시글 추가
		public int insertUpload(UploadDTO upload);
		// 2) attach 게시글 추가
		public int insertAttach(AttachDTO attach);
		// 3) 포인트 처리
		public int updatePoint(String id);
		
		// # 첨부 개별 다운로드	--------------------------------------------
		// 1) 특정 첨부파일 조회
		public AttachDTO selectAttachByNo(int attachNo);
		
		// 2) 첨부파일 다운로드수 증가
		public int updateDownloadCnt(int attachNo);
		
		
		// 4) 포인트 감소시키기 : 파일 한개당 5포인트씩 감소
		public int deletePoint(String id);
		
		// + 포인트 0으로 만들기
		public int DefaultPoint(String id);
		
		// # 첨부 전체 다운로드 --------------------------------------------
		// 1) 특정 첨부파일 전부 조회
		// * 기존 코드를 그대로 사용
		
		// 2) 첨부파일 다운로드수 증가
		// * 위에 코드를 그대로 사용
		
		// # 게시글 수정	--------------------------------------------------
		public int updateUpload(UploadDTO upload);
		
		
		// # 삭제
		
		// 1) 첨부파일 삭제
		public int deleteAttach(int attachNo);
		
		// 2) 첨부파일 전부 삭제
		public int deleteAttachAll(int attachNo);
		
		// 3) 게시글 삭제
		public int deleteUpload(int uploadNo);
		
		
		// # 인터셉터
		// 1) 게시글의 작성자 id 조회	--------------------------------------
		public String selectUserId(int boardNo);
		
		// 2) 유저 포인트 조회
		public Integer selectUserPoint(String id);
		
		// # 검색 조회 	-------------------------------------------------------
		// 1) 조건에 따른 조회수
		public int searchUploadCnt(Map<String, Object> map);
		
		//2 ) 조건에 따른 조회
		public List<UploadDTO> searchUpload(Map<String, Object> map);
			
	
	
	
	
}