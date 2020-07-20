<%@page import="com.exe.dto.CustomInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	<link rel="stylesheet" href="/gyp/resources/css/cart.css" type="text/css">

<title>GYP</title>

<script type="text/javascript">

//전체선택
function fn_AllCheck(parantsObj){
	var obj = document.getElementsByName("cartChk");
	var obj2 = document.getElementsByName("cartNum");
	if(parantsObj.checked){
       for(var i=0; i< obj.length; i++){
	       if(obj[i].checked == false){
	    	   obj[i].checked = true;
	    	   window.price("cartChk"+obj2[i].value,"won"+obj2[i].value);
	       }
       }
	}else{
       for(var i=0; i< obj.length; i++){
    	   if(obj[i].checked == true){
	    	   obj[i].checked = false;
	    	   window.price("cartChk"+obj2[i].value,"won"+obj2[i].value);
	       }
       }
	}
}

	//선택삭제
function SelectDelete(checkboxName){
	var obj = document.getElementsByName(checkboxName);
	var j = 0;
	for(var i=0; i< obj.length; i++){
	       if(obj[i].checked == false){
		   j++;	    	   
	       }
	}
	if(j==obj.length){
		alert("상품을 선택해주세요.");
		return;
	}
	var f = document.myForm;
	f.action = "<%=cp%>/cart_delete.action";
	f.submit();
	
	}
	
	//선택주문
function SelectOrder(checkboxName) {
	var obj = document.getElementsByName(checkboxName);
	var j = 0;
	for(var i=0; i< obj.length; i++){
	       if(obj[i].checked == false){
		   j++;	    	   
	       }
	}
	if(j==obj.length){
		alert("상품을 선택해주세요.");
		return;
	}
	var f = document.myForm;
	f.action = "<%=cp%>/order.action";
	f.submit();
	}

	//하나주문
function OneOrder(checkboxName,cartChk) {
	var obj = document.getElementsByName(checkboxName);
	var obj2 = document.getElementById(cartChk);
	for(var i=0; i< obj.length; i++){
		if(obj[i].value==null||obj[i].value==""){
	    	   alert("\n갯수를 입력하세요.");
	    	   obj[i].focus();
	    	   return;
	     }
		obj2.checked = true;	    	   
	    
	}
	var f = document.myForm;
	f.action = "<%=cp%>/order.action";
	f.submit();
	}
	//가격
	function price(checkboxName,won) {
		var checkBox = document.getElementById(checkboxName);
		var won = document.getElementById(won);
		var totPrice = document.getElementById("totPrice");

		var v3;
		if (checkBox.checked == true) {
			var v1 = Number(totPrice.value);
			var v2 = Number(won.value);
			v3 = v1 + v2;
			totPrice.value = v3;
		}
		if (checkBox.checked == false) {
			var v1 = Number(totPrice.value)
			var v2 = Number(won.value);
    		v3 = v1 - v2;
			totPrice.value = v3;
		}
	}
	

</script>

</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />

	
	<div id="wrapper_cart" style="font-family: 'Noto Sans KR', sans-serif;">
		<form method="post" name="myForm">
			<br>
			<br>
			<br>
			<table style="font-size: 15pt; color: #888" border="0" width="1250"
				cellspacing="3" cellpadding="3">
				<tr valign="top">
					<td colspan="10" align="left"><font
						style="font-size: 20pt; color: black;">&nbsp;&nbsp;장바구니</font>
						<hr>
						<br></td>

					<c:if test="${empty cartLists}">
						<tr>
							<td><br>
							<font color="#F23D4C">담은 물건이 없습니다!</font></td>
					</c:if>

					<c:if test="${!empty cartLists}">

						<tr>
							<td>&nbsp;&nbsp;&nbsp;<input type="checkbox" id="chkAll"
								class="selectAllCarts" onclick="fn_AllCheck(this);"></td>
							<td colspan="8"><label for="chkAll">전체선택</label> 
							<input type="hidden" name="totPrice" value="${totPrice }"></td>
							<td><input align="right" type="button" value="선택삭제"
								onclick="SelectDelete('cartChk');" class="bokyung_button_cart1"
								style="background-color: #555"></td>
						</tr>
						<!-- 선 -->
						<tr height="1">
							<td colspan="10" bgcolor="#cccccc"></td>

							<c:forEach var="cart" items="${cartLists}">
								<tr height="100px">
									<td width="50px">
										<input type="hidden" name="cartNum" value="${cart.cartNum}"> &nbsp;&nbsp; 
										<input type="checkbox" id="cartChk${cart.cartNum}" name="cartChk"
												value="${cart.cartNum}"
												onchange="price('cartChk${cart.cartNum}','won${cart.cartNum}')" /> <!-- pid -->
									<td><label for="cartChk${cart.cartNum}">${cart.productId}</label></td>
									<!-- 이미지 -->
									<td align="center"><img alt="그림" src="<%=cp%>/image/product/${해당 사진불러와서 리스트 넘겨줘야할듯 ★}" width="100px" height="100px"></td>
									<!-- 수량> -->
									<td width="60"><input type="text" name="count${cart.num}" value="${cart.count}" 
											style="font-size:16pt; color: #666; vertical-align: middle;
													width: 50px; height: 45px; padding-top: 2px; text-align: center;
													color:#F23D4C; font-size: 20pt; font-family: 'Do Hyeon', sans-serif;
													vertical-align: middle;"/></td>
									<!-- 변경버튼 -->							
									<td width="70"><input type="button" value="변경" onclick="countUpdate('count${cart.num}','${cart.num}');"
													class="bokyung_button_cart_change"/></td>
									<td width="600px" style="text-align: center;">${cart.productName }</td>

									<td width="500px" style="text-align: center;">${cart.productPrice}원
									<input type="hidden" id="won${cart.cartNum}" value="${cart.productPrice}"/></td>
									

									<td><input type="button" value="구매하기"
										class="btn fitness-btn btn-white mt-10"
										style="min-width: 50px; float: right; margin: 10px 5px 10px 5px; padding: 5px; border-radius: 30px; vertical-align: middle;"
										onclick="OneOrder('count${cart.cartNum}','cartChk${cart.cartNum}');">

										<input type="button" value="삭제하기"
										class="btn fitness-btn btn-white mt-10"
										style="min-width: 50px; float: right; margin: 10px 5px 10px 5px; padding: 5px; border-radius: 30px; vertical-align: middle;"
										onclick="location.href='<%=cp%>/cart_Onedelete.action?cartNum=${cart.cartNum}'"></td>
								</tr>

								<!-- 선 -->
								<tr height="1">
									<td colspan="10" bgcolor="#cccccc"></td>
								</tr>

							</c:forEach>
						</tr>
						<tr valign="bottom" height="150">
							<td colspan="8" align="right" style="padding-bottom: 15px;">
								<font color="black">선택한 상품금액 : <input type="text"
									readonly="readonly" value="0" id="totPrice" name="totPrice"
									style="border: 0; background-color: #DFDFEB; padding-top: 2px; padding-right: 15px; width: 150px; height: 35px; font-size: 15pt; font-family: 'Do Hyeon'; text-align: right;">&nbsp;&nbsp;원
							</font>
							</td>
							<td colspan="2" align="right"><input type="button"
								value="선택주문" onclick="SelectOrder('cartChk');"
								class="bokyung_button_cart2"></td>
						</tr>

					</c:if>
			</table>
		</form>
	</div>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	
    <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="/gyp/resources/js/jquery/jquery-2.2.4.min.js"></script>
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