package com.gdu.semi.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface CommentService {

	public Map<String, Object> getCommentCount(int galNo);
	public Map<String, Object> addComment(HttpServletRequest request);
	public Map<String, Object> getCommentList(HttpServletRequest request);
	public Map<String, Object> removeComment(int commentNo);
}
