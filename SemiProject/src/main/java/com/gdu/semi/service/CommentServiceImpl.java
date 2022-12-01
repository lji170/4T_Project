package com.gdu.semi.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.gdu.semi.domain.CommentDTO;
import com.gdu.semi.mapper.CommentMapper;
import com.gdu.semi.util.PageUtil;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class CommentServiceImpl implements CommentService {
	
	private CommentMapper commentMapper;
	private PageUtil pageUtil;
	

	@Override
	public Map<String, Object> getCommentCount(int galNo) {
		Map<String, Object> result = new HashMap<>();
		result.put("commentCount", commentMapper.selectCommentCount(galNo));
		return result;
	}
	
	@Override
	public Map<String, Object> addComment(HttpServletRequest request) {
		
		int galNo = Integer.parseInt(request.getParameter("galNo"));
		String id = "인절미";
		String commentTitle = request.getParameter("commentTitle");
		
		Optional<String> opt = Optional.ofNullable(request.getHeader("X-Fowarded-For"));
		String ip = opt.orElse(request.getRemoteAddr());
		
		CommentDTO comment = CommentDTO.builder()
				.galNo(galNo)
				.id(id)
				.commentTitle(commentTitle)
				.ip(ip)
				.build();
		
		Map<String, Object> result = new HashMap<>();
		
		// (isAdd, true)
		// (isAdd, false)
		result.put("isAdd", commentMapper.insertComment(comment) == 1);
		return result;
	}
	
	@Override
	public Map<String, Object> getCommentList(HttpServletRequest request) {
		int galNo = Integer.parseInt(request.getParameter("galNo"));
		String id = "인절미";
		String commentTitle = request.getParameter("commentTitle");
		Optional<String> opt = Optional.ofNullable(request.getHeader("X-Fowarded-For"));
		String ip = opt.orElse(request.getRemoteAddr());
		int page = Integer.parseInt(request.getParameter("page"));
		
		int commentCount = commentMapper.selectCommentCount(galNo);
		// 페이지당 10개의 댓글 보기
		pageUtil.setPageUtil(page, 10, commentCount);
		
		Map<String, Object> map = new HashMap<>();
		map.put("galNo", galNo);
		map.put("id", id);
		map.put("commentTitle", commentTitle);
		map.put("ip", ip);
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<>();
		result.put("commentList", commentMapper.selectCommentList(map));
		result.put("pageUtil", pageUtil);
		
		return result;
	}
	
	@Override
	public Map<String, Object> removeComment(int commentNo) {
		Map<String, Object> result = new HashMap<>();
		result.put("isRemove", commentMapper.deleteComment(commentNo) == 1);
		return result;
	}
	
}
