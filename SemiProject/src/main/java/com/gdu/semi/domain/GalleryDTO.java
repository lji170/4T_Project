package com.gdu.semi.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class GalleryDTO {
	
	private int galNo;
	private String id;
	private String galTitle;
	private String galContent;
	private Date galCreateDate;
	private Date galLastModifyDate;
	private int galHit;
	private int likeCount;
	private String ip;
	
	
}