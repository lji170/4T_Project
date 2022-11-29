package com.gdu.semi.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


public interface AdminService {
	public Map<String, Object> getUserList(HttpServletRequest request);
	public Map<String, Object> findUser(HttpServletRequest request);
	public int removeUser(List<String> userNo);
}