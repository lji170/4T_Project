package com.gdu.semi.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GalleryMapper {
	
	public int selectGalleryListCount();
	
}
