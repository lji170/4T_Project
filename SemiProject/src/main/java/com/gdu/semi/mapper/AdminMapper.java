package com.gdu.semi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.UserDTO;

@Mapper
public interface AdminMapper {
	public List<UserDTO> selectAllUsers();
	public int deleteUserById(UserDTO id);
}