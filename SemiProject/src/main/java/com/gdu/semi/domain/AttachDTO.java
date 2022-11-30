package com.gdu.semi.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class AttachDTO {
	
	private int attachNo;
	private int uploadNo;
	private String origin;
	private String filesystem;
	private int downloadCnt;
	private String path;
	
	

}