package com.gdu.semi.mapper;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.UserDTO;

@Mapper
public interface AdminMapper {
	public int selectUserListCount();
	public List<UserDTO> selectUserListByMap(Map<String, Object> map);
	public UserDTO selectUserByNo(int userNo);
	public int deleteUserByNo(HttpServletRequest request);
}