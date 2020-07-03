package com.exe.dto;
// 상품 테이블 PRODUCT
public class ProductDTO {

	private String productId;	// 상품 ID
	private String productName;	// 상품 이름
	private String productImg;	// 상품 이미지
	private String productPrice;	// 상품 가격
	private String productHit;	// 상품 조회수
	private String productContent;	// 상품 설명(내용)
	
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductImg() {
		return productImg;
	}
	public void setProductImg(String productImg) {
		this.productImg = productImg;
	}
	public String getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}
	public String getProductHit() {
		return productHit;
	}
	public void setProductHit(String productHit) {
		this.productHit = productHit;
	}
	public String getProductContent() {
		return productContent;
	}
	public void setProductContent(String productContent) {
		this.productContent = productContent;
	}
	
	
}
