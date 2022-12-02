package com.gdu.semi.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;


public interface AdminService {
	public Map<String, Object> getUserList(HttpServletRequest request);
	public Map<String, Object> findUser(HttpServletRequest request);
	public Map<String, Object> removeUser(Map<String, Object> userNo);
	public Map<String, Object> sleepUser(Map<String, Object> userNo);
	public Map<String, Object> getGalleryList(HttpServletRequest request);
}