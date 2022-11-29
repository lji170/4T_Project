package com.gdu.semi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.semi.mapper.AdminMapper;
import com.gdu.semi.util.PageUtil;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired 
	private AdminMapper adminMapper;
	
	@Autowired 
	private PageUtil pageUtil;
	
	@Override
	public Map<String, Object> getUserList(HttpServletRequest request) {
		int page = Integer.parseInt(request.getParameter("page"));
		
		int userCount = adminMapper.selectUserListCount();
		
		pageUtil.setPageUtil(page, 10, userCount);
		
		Map<String, Object> map = new HashMap<>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("userList", adminMapper.selectUserList(map));
		result.put("pageUtil", pageUtil);
		
		return result;
		
	}
	@Override
	public Map<String, Object> findUser(HttpServletRequest request) {
		String column = request.getParameter("column");
		String searchText = request.getParameter("searchText");
		int page = Integer.parseInt(request.getParameter("page"));
		
		Map<String,	Object> userCountMap = new HashMap<>();
		userCountMap.put("column", column);
		userCountMap.put("searchText",searchText);
		
		int userCount = adminMapper.selectUsersByQueryCount(userCountMap);
		
		pageUtil.setPageUtil(page, 3, userCount);
		
		Map<String, Object> map = new HashMap<>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		map.put("column", column);
		map.put("searchText",searchText);
		
		Map<String, Object> result = new HashMap<>();
		result.put("findUserList", adminMapper.selectUsersByQuery(map));
		result.put("pageUtil", pageUtil);
		
		return result;
		
	}
	@Override
	public int removeUser(List<String> userNo) {
		int result = adminMapper.deleteUserByNo(userNo);
		return result;
	}
		
}
