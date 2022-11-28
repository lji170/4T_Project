package com.gdu.semi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.semi.domain.UserDTO;
import com.gdu.semi.mapper.AdminMapper;
import com.gdu.semi.util.PageUtil;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired 
	private AdminMapper adminMapper;
	
	@Autowired 
	private PageUtil pageUtil;
	
	@Override
	public Map<String, Object> getUserList(HttpServletRequest request, Model model) {
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int totalRecord = adminMapper.selectUserListCount();
		
		pageUtil.setPageUtil(page, 10, totalRecord);
		
		Map<String, Object> map = new HashMap<>();
		map.put("begin", pageUtil.getBegin());
		map.put("end", pageUtil.getEnd());
		
		List<UserDTO> userList = adminMapper.selectUserListByMap(map);
		
		model.addAttribute("userList", userList);
		model.addAttribute("totalRecord", totalRecord);
		model.addAttribute("beginNo", totalRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging(request.getContextPath() + "/admin/userList"));
		
		return map;

		
	}
	
	@Override
	public int removeUserByNo(HttpServletRequest request) {
		
		return adminMapper.deleteUserByNo(request);
	}
	@Override
	public UserDTO getUserNo(int userNo) {
		
		return adminMapper.selectUserByNo(userNo);
	}
}
