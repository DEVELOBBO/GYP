package com.exe.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.dto.GymDTO;
import com.exe.dto.ReviewDTO;

/*gymDetail페이지에서 사용하는 모든 dao 메소드*/
public class GypDAO {
	
private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate; 
	}
	
	// getGymList : 체육관 하나의 정보 받아오기
	public GymDTO getGymData(String gymId){
		
		GymDTO gymDto = sessionTemplate.selectOne("gymDetailMapper.getGymData", gymId);
		return gymDto;
		
	}

	// getReviewNumMax : 리뷰 전체의 최댓값 : 데이터 삽입시 필요
	public int getReviewNumMax() {
		
		int result = sessionTemplate.selectOne("gymDetailMapper.getReviewNumMax");
		return result;
		
	}
	
	// getReviewNum : 체육관 하나에 달린 리뷰 갯수
	public int getReviewNum(String gymId) {
		
		int result = sessionTemplate.selectOne("gymDetailMapper.getReviewNum", gymId);
		return result;
		
	}
	
	// getReviewData : 체육관 하나의 전체 리뷰 리스트 받아오기
	public List<ReviewDTO> getReviewList(Map<String, Object> hMap) {
		
		List<ReviewDTO> reviewLists  = sessionTemplate.selectList("gymDetailMapper.getReviewList",hMap);
		return reviewLists;
		
	}
	
	// insertReviewData : 리뷰 삽입
	public void insertReviewData(ReviewDTO dto) {
		
		sessionTemplate.insert("gymDetailMapper.insertReviewData", dto);
		
	}
	
	// deleteReviewData : 리뷰 삭제
	public void deleteReviewData(int gymId) {
		
		sessionTemplate.delete("gymDetailMapper.deleteReviewData",gymId);
		
	}
	

}
