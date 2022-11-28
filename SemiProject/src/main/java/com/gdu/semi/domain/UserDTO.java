package com.gdu.semi.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserDTO {
   private int userNo;
   private String id;
   private String pw;
   private String name;
   private String gender;
   private String email;
   private String mobile;
   private String birthyear;
   private String birthday;
   private String postcode;
   private String roadAddress;
   private String jibunAddress;
   private String detailAddress;
   private String extraAddress;
   private int agreeCode;
   private String snsType;
   private Date joinDate;
   private Date pwModifyDate;
   private Date infoModifyDate;
   private String sessionId;
   private Date sessionLimitDate;
   private int point;
}