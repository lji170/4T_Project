package com.gdu.app14.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class AttachDTO {
	private int attachNo;
	private String path;
	private String origin;
	private String filesystem;
	private int downloadCnt;
	private int uploadNo;
}