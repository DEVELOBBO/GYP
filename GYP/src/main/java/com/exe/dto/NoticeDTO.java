package com.exe.dto;
// 공지사항 테이블 NOTICE
public class NoticeDTO {

	private int notiNum;	 // 공지 번호
	private String notiTitle;	// 공지 제목
	private String notiContent;	// 공지 내용
	private String notiCreated;	// 공지 생성일
	
	public int getNotiNum() {
		return notiNum;
	}
	public void setNotiNum(int notiNum) {
		this.notiNum = notiNum;
	}
	public String getNotiTitle() {
		return notiTitle;
	}
	public void setNotiTitle(String notiTitle) {
		this.notiTitle = notiTitle;
	}
	public String getNotiContent() {
		return notiContent;
	}
	public void setNotiContent(String notiContent) {
		this.notiContent = notiContent;
	}
	public String getNotiCreated() {
		return notiCreated;
	}
	public void setNotiCreated(String notiCreated) {
		this.notiCreated = notiCreated;
	}
	
}
