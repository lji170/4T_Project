package com.gdu.semi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.http.ResponseEntity;

import com.gdu.semi.domain.GalleryDTO;
import com.gdu.semi.domain.LikeDTO;
import com.gdu.semi.domain.SummernoteImageDTO;
import com.gdu.semi.domain.UserDTO;

@Mapper
public interface GalleryMapper {
	
	public int selectGalleryListCount();
	public List<GalleryDTO> selectGalleryList();
	public List<GalleryDTO> selectGalleryListByMap(Map<String, Object> map);
	
	// 갤러리 작성
	public int insertSummernoteImage(SummernoteImageDTO summernote);
	public int insertGallery(GalleryDTO gallery);
	public int updateUserPoint(String id);
	
	public int updateHit(int galNo);
	public GalleryDTO selectGalleryByNo(int galNo);
	
	// 좋아요
	public int selectLikeUser(LikeDTO like);
	public int insertLike(LikeDTO like);
	public int deleteLike(LikeDTO like);
	
	// 갤러리 수정
	public int updateGallery(GalleryDTO gallery);
	
	public int deleteGallery(int galNo);
	public List<SummernoteImageDTO> selectSummernoteImageListInBlog(int blogNo);
	public List<SummernoteImageDTO> selectAllSummernoteImageList();
	
}
