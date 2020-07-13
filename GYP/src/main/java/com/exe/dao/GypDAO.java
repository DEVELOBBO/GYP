package com.exe.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.exe.dto.BookDTO;
import com.exe.dto.CustomInfo;
import com.exe.dto.CustomerDTO;
import com.exe.dto.GymDTO;
import com.exe.dto.JjimDTO;
import com.exe.dto.NoticeDTO;
import com.exe.dto.QnaDTO;
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
	
	//회원정보 수정 (유저)
	public void updateData(CustomerDTO dto) {
		sessionTemplate.update("customerMapper.updateData", dto);
	}
	
	// 회원정보 수정(체육관)
	public void gymupdateData(GymDTO gymdto) {
		sessionTemplate.update("gymMapper.gymupdateData", gymdto);
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
	
	//회원정보 삭제(유저)
	public void deleteData(CustomerDTO dto) {
		sessionTemplate.delete("customerMapper.deleteData", dto);
	}
	
	// 회원정보 삭제(체육관)
	public void gymdeleteData(GymDTO dto) {
		sessionTemplate.delete("gymMapper.gymdeleteData", dto);
	}
	
	//로그인시 값이 존재하는지 확인
	public int getDataCount(String cusId) {
		int result = sessionTemplate.selectOne("loginMapper.getDataCount", cusId);
		return result;
	}
	
	// 리뷰 리스트(유저)
	public List<ReviewDTO> reviewgetList(String reviewId) {
		List<ReviewDTO> reviewlists = sessionTemplate.selectList("customerMapper.reviewgetLists", reviewId);
		return reviewlists;
	}
	
	// 리뷰 리스트(체육관)
	public List<ReviewDTO> gymreviewgetList(String reviewId) {
		List<ReviewDTO> gymreviewlists = sessionTemplate.selectList("gymMapper.gymreviewgetLists", reviewId);
		return gymreviewlists;
	}
	
	// 리뷰 삭제
	public void reviewdeleteData(int reNum) {
		sessionTemplate.delete("customerMapper.reviewdeleteData", reNum);
	}
	
	// 찜 리스트
	public List<JjimDTO> jjimgetList(String jjimId) {
		List<JjimDTO> jjimlists = sessionTemplate.selectList("customerMapper.jjimgetLists", jjimId);
		return jjimlists;
	}
	
	// 찜 삭제
	public void jjimdeleteData(String gymId) {
		sessionTemplate.delete("customerMapper.jjimdeleteData", gymId);
	}
	
	// 예약 리스트(유저)
	public List<BookDTO> bookgetList(String bookId) {
		List<BookDTO> booklists = sessionTemplate.selectList("customerMapper.bookgetLists", bookId);
		return booklists;
	}
	
	// 예약 리스트(체육관)
	public List<BookDTO> gymbookgetList(String bookId) {
		List<BookDTO> gymbooklists = sessionTemplate.selectList("gymMapper.gymbookgetLists", bookId);
		return gymbooklists;
	}
	
	// 예약 삭제
	public void bookdeleteData(int bookNum) {
		sessionTemplate.delete("customerMapper.bookdeleteData", bookNum);
	}
	
	//예약 데이터 개수
	public int bookgetDataCount(Map<String, Object> hMap) {
		int result = sessionTemplate.selectOne("gymMapper.getDataCount",hMap);
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
	
	//*******************서예지*******************
	
	// 공지사항 최댓값
	public int getNoticeMaxNum(){
		
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("notice.maxNum");
		return maxNum;
	}
	
	// 공지사항 추가
	public void insertNotice(NoticeDTO dto){
		sessionTemplate.insert("notice.insertData",dto);
	}
	
	// 공지사항 데이터 갯수
	public List<NoticeDTO> getNoticeList(int start, int end){
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", start);
		params.put("end", end);
		List<NoticeDTO> lists = sessionTemplate.selectList("notice.getLists",params);
		return lists;
	}
	
	//공지사항 1개 가져오기
	public NoticeDTO getNoticeReadData(int notiNum){
		NoticeDTO dto = sessionTemplate.selectOne("notice.getReadData",notiNum);
		return dto;
	}
	
	//공지사항 이전글
	public NoticeDTO getNoticePreReadData(int notiNum){
		NoticeDTO dto = sessionTemplate.selectOne("notice.preReadData",notiNum);
		return dto;
	}
	
	//공지사항 다음글
	public NoticeDTO getNoticeNextReadData(int notiNum){
		NoticeDTO dto = sessionTemplate.selectOne("notice.nextReadData",notiNum);
		return dto;
	}
	
	// 공지사항 데이터 리스트 가져오기
	public int getNoticeDataCount(){
		int result = sessionTemplate.selectOne("notice.getDataCount");
		return result;
	}
	
	//공지사항 삭제
	public void deleteNoticeData(int notiNum){
		sessionTemplate.delete("notice.deleteData",notiNum);
	}
	
	//공지사항 수정
	public void updateNoticeData(NoticeDTO dto){
		sessionTemplate.update("notice.updateData",dto);
	}

	//-------------qna--------------------
	
	// Q&A 최댓값
	public int getQnaMaxNum(){
		int maxNum = 0;
		maxNum = sessionTemplate.selectOne("qna.maxNum");
		return maxNum;
	}
	
	// Q&A 추가
	public void insertQna(QnaDTO dto){
		sessionTemplate.insert("qna.insertData",dto);
	}
	
	// Q&A 데이터 갯수
	public List<QnaDTO> getQnaList(int start, int end,String searchKey,String searchValue){
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("start", start);
		params.put("end", end);
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		List<QnaDTO> lists = sessionTemplate.selectList("qna.getLists",params);
		return lists;
	}
	
	//Q&A 데이터 1개
	public QnaDTO getQnaReadData(int qnaNum){
		QnaDTO dto = sessionTemplate.selectOne("qna.getReadData",qnaNum);
		return dto;
	}
	
	//Q&A 이전글
	public QnaDTO getQnaPreReadData(int qnaNum,String searchKey,String searchValue){
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		params.put("qnaNum", qnaNum);
		
		QnaDTO dto = sessionTemplate.selectOne("qna.preReadData",params);
		return dto;
	}

	//Q&A 다음글
	public QnaDTO getQnaNextReadData(int qnaNum,String searchKey,String searchValue){
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("searchKey", searchKey);
		params.put("searchValue", searchValue);
		params.put("qnaNum", qnaNum);
		
		QnaDTO dto = sessionTemplate.selectOne("qna.nextReadData",params);
		return dto;
	}
	
	// Q&A 데이터 갯수 가져오기
	public int getQnaDataCount(String searchKey,String searchValue){
			HashMap<String,Object> params = new HashMap<String,Object>();
			params.put("searchKey", searchKey);
			params.put("searchValue", searchValue);
			int result = sessionTemplate.selectOne("qna.getDataCount",params);
			return result;
		}

	//orderNo 정렬
	public void orderNoUpdate(String qnaGroupNum,String qnaOrderNo) {
		HashMap<String,Object> params = new HashMap<String,Object>();
		params.put("qnaGroupNum", qnaGroupNum);
		params.put("qnaOrderNo", qnaOrderNo);
		sessionTemplate.update("qna.orderNoUpdate",params);
	}
	
	//QnA삭제
	public void deleteQnaData(int qnaNum){
		sessionTemplate.delete("qna.deleteData",qnaNum);
	}
	
	//QnA수정
	public void updateQnaData(QnaDTO dto){
		sessionTemplate.update("qna.updateData",dto);
	}
	
	//*******************채종완*******************
	 
	//cusCreated : 개인회원가입정보 삽입
	public void cusCreated(CustomerDTO dto) {
		sessionTemplate.insert("createMapper.insertCus",dto);
	}
	
	// gymCreated : 체육관 회원가입정보 삽입
	public void gymCreated(GymDTO dto) {
		sessionTemplate.insert("createMapper.insertGym",dto);
	}
	
	//아이디 체크
	public void idCheck(CustomerDTO dto) {
		sessionTemplate.selectOne("createMapper.idCheck", dto);
	}
	
	
	//*******************최보경*******************
	
	//getCusAddr : 로그인한 회원의 주소 가져오기
	public String getCusAddr(String sessionId) {
		String customerAddr = sessionTemplate.selectOne("recommend.customerAddr", sessionId);
		return customerAddr;
	}
	
	//gymRecommend : 회원 주소를 기반으로 메인화면에서 체육관 추천 
	public List<GymDTO> getGymRecommend(String customerAddr){
		List<GymDTO> nearGymLists = sessionTemplate.selectList("recommend.nearGymList", customerAddr);
		return nearGymLists;
	}
	
	//gymRecommendDefault : 로그인하지 않은 화면에서 체육관 추천
	public List<GymDTO> getGymRecommendDefault(){
		List<GymDTO> nearGymDefaultLists = sessionTemplate.selectList("recommend.nearGymDefaultLists");
		return nearGymDefaultLists;
	}
	
}

























