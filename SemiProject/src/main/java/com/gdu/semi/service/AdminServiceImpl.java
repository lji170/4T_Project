package com.gdu.semi.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gdu.semi.domain.RetireUserDTO;
import com.gdu.semi.domain.SleepUserDTO;
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
      
      Map<String,   Object> userCountMap = new HashMap<>();
      userCountMap.put("column", column);
      userCountMap.put("searchText",searchText);
      
      int userCount = adminMapper.selectUsersByQueryCount(userCountMap);
      
      pageUtil.setPageUtil(page, 10, userCount);
      
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
   
   @Transactional
   @Override
   public Map<String, Object> removeUser(Map<String, Object> userNo) {
      

      Map<String,   Object> deleteUser = new HashMap<>();
      List<UserDTO> users = adminMapper.selectUserByNo(userNo);

      List<RetireUserDTO> retireUserList = new ArrayList<>();
      for(int i = 0; i < users.size(); i ++) {
         RetireUserDTO retireUser = new RetireUserDTO();
         retireUser.setId(users.get(i).getId());
         retireUser.setJoinDate(users.get(i).getJoinDate());
         retireUserList.add(i, retireUser);
      }
      Map<String, Object> rUser = new HashMap<>();
      rUser.put("retireUsers", retireUserList);
      int insertResult = adminMapper.insertRetireUser(rUser);
      int deleteResult = adminMapper.deleteUserByNo(userNo);

      deleteUser.put("isRemove", deleteResult);
      System.out.println(insertResult +"," + deleteResult);

      
      return deleteUser;
      
   }
   
   @Transactional
   @Override
   public Map<String, Object> sleepUser(Map<String, Object> userNo) {
      Map<String,   Object> sleepUser = new HashMap<>();
      List<UserDTO> users = adminMapper.selectUserByNo(userNo);
      
      
      List<SleepUserDTO> sleepUserList = new ArrayList<>();
      for(int i = 0; i < users.size(); i++) {
         SleepUserDTO setSleepUser = SleepUserDTO.builder()
               .id(users.get(i).getId())
               .pw(users.get(i).getPw())
               .name(users.get(i).getName())
               .gender(users.get(i).getGender())
               .email(users.get(i).getEmail())
               .mobile(users.get(i).getMobile())
               .birthyear(users.get(i).getBirthyear())
               .birthday(users.get(i).getBirthyear())
               .postcode(users.get(i).getPostcode())
               .roadAddress(users.get(i).getRoadAddress())
               .jibunAddress(users.get(i).getJibunAddress())
               .detailAddress(users.get(i).getDetailAddress())
               .extraAddress(users.get(i).getExtraAddress())
               .agreeCode(users.get(i).getAgreeCode())
               .snsType(users.get(i).getSnsType())
               .joinDate(users.get(i).getJoinDate())
               //.lastLoginDate(Date)
               .pwModifyDate(users.get(i).getPwModifyDate())
               .point(users.get(i).getPoint())
               .build();
         sleepUserList.add(i, setSleepUser);
      }
         
         Map<String, Object> sUser = new HashMap<>();
         sUser.put("sleepUsers", sleepUserList);
         
         System.out.println(sUser);
         int insertResult = adminMapper.insertSleepUser(sUser);
         int deleteResult = adminMapper.deleteUserByNo(userNo);
         
         sleepUser.put("isSleepUser", deleteResult);
         System.out.println(insertResult +"," + deleteResult);
         
         return sleepUser;
      
      
   }
   @Override
   public Map<String, Object> getGalleryList(HttpServletRequest request) {
      int page = Integer.parseInt(request.getParameter("page"));
      
      int galleryCount = adminMapper.selectGalleryListCount();
      
      pageUtil.setPageUtil(page, 10, galleryCount);
      
      Map<String, Object> map = new HashMap<>();
      map.put("begin", pageUtil.getBegin());
      map.put("end", pageUtil.getEnd());
      
      Map<String, Object> result = new HashMap<>();
      
      result.put("galleryList", adminMapper.selectGalleryListByMap(map));
      result.put("pageUtil", pageUtil);
      
      return result;
   }
   
   
   
}