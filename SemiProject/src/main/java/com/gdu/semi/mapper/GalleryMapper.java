package com.gdu.semi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.semi.domain.GalleryDTO;
import com.gdu.semi.domain.LikeDTO;
import com.gdu.semi.domain.SummernoteImageDTO;

@Mapper
public interface GalleryMapper {
	
	public int selectGalleryListCount();
	public List<GalleryDTO> selectGalleryList();
	public List<GalleryDTO> selectGalleryListByMap(Map<String, Object> map);
	public int selectFindGalleryListCount(Map<String, Object> map);
	public List<GalleryDTO> selectFindGalleryList(Map<String, Object> map);
	public int selectGallerySummmernote(int galNo);
	
	// 갤러리 작성
	public int insertSummernoteImage(SummernoteImageDTO summernote);
	public int insertGallery(GalleryDTO gallery);
	public int updateUserPoint(String id);
	
	public int updateHit(int galNo);
	public GalleryDTO selectGalleryByNo(int galNo);
	
	// 좋아요
	public int selectLikeCount(int galNo);
	
	public int updateLikeCount(int galNo);
	public int selectLikeUser(LikeDTO like);
	public int insertLike(LikeDTO like);
	public int deleteLike(LikeDTO like);
	
	// 갤러리 수정
	public int updateGallery(GalleryDTO gallery);
	// 갤러리 삭제
	public int deleteGallery(int galNo);
	public List<SummernoteImageDTO> selectSummernoteImageListInBlog(int blogNo);
	public List<SummernoteImageDTO> selectAllSummernoteImageList();
	
}
