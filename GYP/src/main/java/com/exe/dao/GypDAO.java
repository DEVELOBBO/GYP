package com.exe.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.dto.CustomInfo;
import com.exe.dto.CustomerDTO;
import com.exe.dto.GymDTO;
import com.exe.dto.ReviewDTO;

public class GypDAO {
	
private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) throws Exception{
		this.sessionTemplate = sessionTemplate; 
	}
	
	//*******************원도현*******************
	
	//일반유저 로그인
	public CustomerDTO getLoginReadData(String cusId) {//비밀번호 찾기
		CustomerDTO dto = sessionTemplate.selectOne("loginMapper.getLoginReadData", cusId);
		return dto;
	}
	//체육관 로그인
	public GymDTO getGymLoginReadData(String cusId) {//비밀번호 찾기
		GymDTO dto = sessionTemplate.selectOne("loginMapper.getGymLoginReadData", cusId);
		return dto;
	}
	
	//아이디 찾기
	public CustomerDTO getLoginIdReadData(Map<String, Object> hMap) {
		CustomerDTO dto = sessionTemplate.selectOne("loginMapper.getLoginIdReadData", hMap);
		return dto;
	}
	
	//회원정보 수정
	public void updateData(CustomerDTO dto) {
		sessionTemplate.update("customerMapper.updateData", dto);
	}
	
	//회원정보 불러오기 (유저)
	public CustomerDTO getReadData(CustomInfo info) {
		CustomerDTO dto = sessionTemplate.selectOne("customerMapper.getReadData", info);
		return dto;
	}
	
	//회원정보 불러오기 (체육관)
	public GymDTO getgymReadData(CustomInfo info) {
		GymDTO dto = sessionTemplate.selectOne("gymMapper.getgymReadData", info);
		return dto;
	}
	
	//회원정보 삭제(user)
	public void deleteData(CustomerDTO dto) {
		sessionTemplate.delete("customerMapper.deleteData", dto);
	}
	
	//로그인시 값이 존재하는지 확인
	public int getDataCount(String cusId) {
		int result = sessionTemplate.selectOne("loginMapper.getDataCount", cusId);
		return result;

	}
	
	//*******************김세이*******************
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
	
	
	//*******************채종완*******************
	public void cusCreated(CustomerDTO dto) {
		sessionTemplate.insert("cusMapper.insertCus",dto);
	}

	public void gymCreated(GymDTO dto) {
		sessionTemplate.insert("cusMapper.insertGym",dto);
	}
	
	
}
