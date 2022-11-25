package com.gdu.semi.service;

import java.util.List;

import com.gdu.semi.domain.UserDTO;


public interface AdminService {
	public List<UserDTO> getUserList();
	public int removeUserById(String id);
}