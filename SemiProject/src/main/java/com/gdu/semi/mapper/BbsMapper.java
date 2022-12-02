package com.gdu.semi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.BbsDTO;

@Mapper
public interface BbsMapper {
	public int selectAllBbsCount();
	public List<BbsDTO> selectAllBbsList(Map<String, Object> map);
	public int insertBbs(BbsDTO bbs);				// 원글 삽입
	public int updatePreviousReply(BbsDTO bbs);		// 댓글 삽입 전 기존 답급의 GROUP_ORDER 업데이트
	public int insertReply(BbsDTO bbs);				// 댓글 삽입
	public int deleteBbs(int bbsNo);
	public int updateBbsNo(BbsDTO bbs);  //수정

}
