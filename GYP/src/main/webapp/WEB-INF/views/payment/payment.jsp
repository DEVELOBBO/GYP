<%@page import="com.exe.dto.CustomInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Favicon -->
	<link rel="icon" href="/gyp/resources/img/core-img/favicon.ico">
	<!-- Core Stylesheet -->
	<link rel="stylesheet" href="/gyp/resources/css/style.css">
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
	<!-- jQuery-2.2.4 js -->
    <script src="/gyp/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- iamport payment js -->
 	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
 	
	<!-- 결제 -->
	<link rel="stylesheet" href="/gyp/resources/css/payment.css">
 	<!-- payment js -->
 	<script type="text/javascript" src="/gyp/resources/js/payment.js"></script>
	
<title>GYP</title>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />

	    <!-- ##### Contact Area Start ##### -->
    <section class="contact-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="title mb-100">
                        <h3>결제하기</h3>
                    </div>
                </div>
            </div>

            <div class="row">
            	<!-- ------------좌측 컬럼 시작------------- -->
                <div class="col-12 col-md-8" id="paymentLeftCol">
                	<div class="row">
                		<div class="contact-content" style="width: 80%;">
                    
                        <!-- 주문 정보 폼 -->
                        <div class="contact-form-area">
                            <form action="#" method="post" name="payForm" id="payForm">
                            
                            	<!-- 주문 상품 -->
                            	<span>주문상품</span>
                            	<div id="주문 상품">
	                            	<div class="form-group">
	                                    <span class="form-control" id="item">${passSelected }</span>
	                                </div>
                            	</div>
                            	
                            	<!-- 주문자 정보 -->
                            	<span>주문자</span>
                            	<div id="주문자">
	                            	<div class="form-group">
	                                    <input type="text" class="form-control" id="buyer_name" placeholder="이름" disabled="disabled" value="${cusName }" />
	                                </div>
	                                <div class="form-group">
	                                    <input type="text" class="form-control" id="buyer_tel" placeholder="전화번호" disabled="disabled" value="${cusTel }">
	                                </div>
	                                <div>
	                                	<input type="hidden" id="buyer_addr" value="${cusAddr }">
	                                </div>
                            	</div>
                                
                                <c:if test="${empty passSelected }">
	                                <!-- 배송지 정보 -->
	                            	<span>배송지</span>
	                                <!-- c:if문 써서 주문 상품이 운동용품일때만 보이기 -->
	                                <div id="배송지">
										<input type="radio" name="deliveryInfo" value="originalDeliver" onclick="copyCusInfo();" checked="checked" >주문자 정보와 동일&nbsp;
										<input type="radio" name="deliveryInfo" value="newDeliver" onclick="resetValue();">새로 입력
										
	                                	<div class="form-group">
		                                    <input type="text" class="form-control" id="receiver_name" placeholder="수령인">
		                                    <input type="text" class="form-control" id="receiver_tel" placeholder="연락처">
		                                    <input type="text" class="form-control" id="receiver_addr" placeholder="배송지 주소">
		                                </div>
	                                </div>
		                        </c:if>
		                        <!-- 결제 수단 선택 -->
                            	<span>결제수단</span>
		                        <div id="결제수단" class="form-group">
			                        <select name="payMethod" id="payMethod" class="form-control" style="height: auto; padding:10px;">
										<option value="card" selected="selected">신용카드</option>
										<option value="trans">실시간계좌이체</option>
										<option value="vbank">가상계좌</option>
										<option value="phone">휴대폰소액결제</option>
									</select>
		                        </div>
                            </form>
                        </div>
                        
                    </div>
                    </div>
                </div>
            	<!-- ------------좌측 컬럼 끝------------- -->
            	<!-- ------------우측 컬럼 시작------------- -->
                <div class="col-12 col-md-4" id="paymentRightCol">
                	
                        <!-- 결제 -->
                        <div id="결제">
	                         <!-- 최종 결제 금액 -->
		                        <div style="margin:10px 0;">
			                        <span class="pay-left">최종 결제 금액 : </span><br/>
			                        <span class="pay-right" style="font-size:40px;">&#8361;<fmt:formatNumber value="${finalPayVal }" pattern="#,###" /></span>
			                        <input type="hidden" id="amount" value="${finalPayVal }"/>
		                        </div>
	                        <!-- 주문하기 -->
	                        <input class="btn fitness-btn btn-2 mt-30" type="button" value="주문하기" id="buyit"
	                        	style="width: 100%; margin:10px 0;" />
                        </div>
                
                </div>
            	<!-- ------------우측 컬럼 끝------------- -->
            </div>
        </div>
    </section>
    <!-- ##### Contact Area End ##### -->

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	
    <!-- ##### All Javascript Script ##### -->
    <!-- Popper js -->
    <script src="/gyp/resources/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="/gyp/resources/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="/gyp/resources/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="/gyp/resources/js/active.js"></script>
    


</body>
</html>