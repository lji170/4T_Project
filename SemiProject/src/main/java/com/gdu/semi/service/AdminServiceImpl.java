package com.gdu.semi.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.semi.domain.UserDTO;
import com.gdu.semi.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired 
	private AdminMapper adminMapper;
	
	@Override
	public List<UserDTO> getUserList() {
		return adminMapper.selectAllUsers();
	}
	
	@Override
	public int removeUserById(String id) {
		// TODO Auto-generated method stub
		return 0;
	}
}
