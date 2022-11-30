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
public class CommentDTO {

	private int commentNo;
	private long galNo;
	private String id;
	private String commentTitle;
	private Date commentCreateDate;
	private Date commentLastModifyDate;
	private String ip;
	
}