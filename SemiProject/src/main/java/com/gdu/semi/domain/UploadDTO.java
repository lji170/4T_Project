package com.gdu.semi.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class UploadDTO {
	
	private int uploadNo;
	private String id;
	private String uploadTitle;
	private String uploadContent;
	private Date uploadCreateDate;
	private Date uploadLastModifyDate;
	private int uploadHit;
	private String ip;

	
}
