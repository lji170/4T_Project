package com.gdu.semi.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.RetireUserDTO;
import com.gdu.semi.domain.SleepUserDTO;
import com.gdu.semi.domain.UserDTO;

@Mapper
public interface UserMapper {

	public UserDTO selectUserByMap(Map<String, Object> map);
	public RetireUserDTO selectRetireUserById(String id);
	public int insertUser(UserDTO user);
	public int updateAccessLog(String id);
	public int insertAccessLog(String id);
	public int deleteUser(int userNo);
	public int insertRetireUser(RetireUserDTO retireUser);
	public int updateSessionInfo(UserDTO user);
	public int updateUserPassword(Map<String, Object> map);
	public int insertSleepUser();
	public int deleteUserForSleep();
	public SleepUserDTO selectSleepUserById(String id);
	public int insertRestoreUser(String id);
	public int deleteSleepUser(String id);
	public int insertNaverUser(UserDTO user);
	
	public SleepUserDTO selectIdSleepUser(Map<String, Object> map);
	
	public int updateUserInfo(Map<String, Object> map);
	
	
	
}
