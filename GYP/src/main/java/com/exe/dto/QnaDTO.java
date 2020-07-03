package com.exe.dto;
// Q&A 테이블
public class QnaDTO {
	
	private int qnaNum;	// QNA 번호
	private String qnaType;	// QNA 타입 (체육관/상품)
	private String cusId;	// 회원번호
	private String qnaTitle;	// QNA 제목
	private String qnaContent;	// QNA 내용
	private String qnaCreated;	// QNA 생성일
	private String qnaGroupNum;	// QNA 그룹 Num
	private int qnaDepth;	//  깊이 : 답변시 사용
	private int qnaOrderNo;	// 그룹 내의 순서
	private int qnaParent;	// QNA 게시글 부모
	
	public int getQnaNum() {
		return qnaNum;
	}
	public void setQnaNum(int qnaNum) {
		this.qnaNum = qnaNum;
	}
	public String getQnaType() {
		return qnaType;
	}
	public void setQnaType(String qnaType) {
		this.qnaType = qnaType;
	}
	public String getCusId() {
		return cusId;
	}
	public void setCusId(String cusId) {
		this.cusId = cusId;
	}
	public String getQnaTitle() {
		return qnaTitle;
	}
	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}
	public String getQnaContent() {
		return qnaContent;
	}
	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}
	public String getQnaCreated() {
		return qnaCreated;
	}
	public void setQnaCreated(String qnaCreated) {
		this.qnaCreated = qnaCreated;
	}
	public String getQnaGroupNum() {
		return qnaGroupNum;
	}
	public void setQnaGroupNum(String qnaGroupNum) {
		this.qnaGroupNum = qnaGroupNum;
	}
	public int getQnaDepth() {
		return qnaDepth;
	}
	public void setQnaDepth(int qnaDepth) {
		this.qnaDepth = qnaDepth;
	}
	public int getQnaOrderNo() {
		return qnaOrderNo;
	}
	public void setQnaOrderNo(int qnaOrderNo) {
		this.qnaOrderNo = qnaOrderNo;
	}
	public int getQnaParent() {
		return qnaParent;
	}
	public void setQnaParent(int qnaParent) {
		this.qnaParent = qnaParent;
	}
	
	

}
