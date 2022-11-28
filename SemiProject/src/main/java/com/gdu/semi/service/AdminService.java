package com.gdu.semi.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.gdu.semi.domain.UserDTO;


public interface AdminService {
	public Map<String, Object> getUserList(HttpServletRequest request, Model model);
	public int removeUserByNo(HttpServletRequest request);
	public UserDTO getUserNo(int userNo);
}