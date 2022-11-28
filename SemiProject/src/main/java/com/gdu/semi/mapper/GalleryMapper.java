package com.gdu.semi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.http.ResponseEntity;

import com.gdu.semi.domain.GalleryDTO;

@Mapper
public interface GalleryMapper {
	
	public int selectGalleryListCount();
	public List<GalleryDTO> selectGalleryList();
	public List<GalleryDTO> selectGalleryListByMap(Map<String, Object> map);
	public int insertGallery(GalleryDTO gallery);
	public int updateHit(int galNo);
	public GalleryDTO selectGalleryByNo(int galNo);
	public int updateGallery(GalleryDTO gallery);
	public int updateGalleryLikeCount(GalleryDTO gallery);
	public int deleteGallery(int galNo);
	
}
