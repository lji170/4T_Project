package com.gdu.semi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.UserDTO;

@Mapper
public interface AdminMapper {
	public int selectUserListCount();
	public List<UserDTO> selectUserList(Map<String, Object> map);
	public List<UserDTO> selectUsersByQuery(Map<String, Object> map);
	public int selectUsersByQueryCount(Map<String, Object> map);
	public int deleteUserByNo(Map<String, Object> map);
}