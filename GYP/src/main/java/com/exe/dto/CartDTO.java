package com.exe.dto;
// 장바구니 테이블 CART
public class CartDTO {

	private int cartNum;	// 장바구니 번호
	private String cusId;	// 회원 아이디
	private String productId;	// 상품 번호
	private int count;	// 
	
	public int getCartNum() {
		return cartNum;
	}
	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}
	public String getCusId() {
		return cusId;
	}
	public void setCusId(String cusId) {
		this.cusId = cusId;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
}
