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
	
	<!-- 상품상세 CSS -->
	<link rel="stylesheet" href="/gyp/resources/css/productList.css">
	
<script type="text/javascript">
	function search(){
			    
		var f = document.searchForm;
				    
		f.action = "<%=cp%>/productList.action";
		f.submit();
	}
	
	//조회수
	function hit() {
		var f = document.orderby;
	    
		f.action = "<%=cp%>/productList.action";
		f.submit();
	}
	
	//높은가격순
	function hit2() {
		var f = document.orderby;
	    
		f.action = "<%=cp%>/productList.action";
		f.submit();
	}
	//낮은가격순
	function hit3() {
		var f = document.orderby;
	    
		f.action = "<%=cp%>/productList.action";
		f.submit();
	}
</script>

<title>GYP</title>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
	
	<a href="/gyp/cart.action">바구니 바로가기</a> 
	
	<div class="wrapper">
		<div class="wrapper_inner"
			style="font-family: 'Noto Sans KR', sans-serif;">
			<!-- Gallery -->
			<font color="#7a7ebf">&nbsp;&nbsp;Total ${dataCount }
				articles, ${totalPage } pages / Now page is ${currentPage }</font>
			<form action="" method="get" name="searchForm" class="form-signin">
				<select name="searchValueCategory" class="selectField">
					<option value="all">전체</option>
					<option value="H">헬스</option>
					<option value="Y">요가</option>
					<option value="P">필라테스</option>
					<!-- <option value="prod_price">가격</option> -->
				</select> <input type="text" name="searchValueWord" class="textField" />
				<input type="button" value="검 색" class="btn2" onclick="search();" />
			</form>

			<form action="" method="get" name="orderby" class="form-signin">
				<c:if test="${empty productType}">
					<input type="button" value=" 높은가격순"
						style="float: right; background-color: white; border: 0em; color: #7a7ebf"
						onclick="javascript:location.href='<%=cp%>/productList.action?type=1&searchValueCategory=${searchValueCategory }&searchValueWord=${searchValueWord }&pageNum=${pageNum }';">
					<input type="button" value=" 낮은가격순 |"
						style="float: right; background-color: white; border: 0em; color: #7a7ebf"
						onclick="javascript:location.href='<%=cp%>/productList.action?type=2&searchValueCategory=${searchValueCategory }&searchValueWord=${searchValueWord }&pageNum=${pageNum }';">
					<input type="button" value="조회수 |"
						style="float: right; background-color: white; border: 0em; color: #7a7ebf"
						onclick="javascript:location.href='<%=cp%>/productList.action?type=3&searchValueCategory=${searchValueCategory }&searchValueWord=${searchValueWord }&pageNum=${pageNum }';">
				</c:if>
				
				<c:if test="${!empty productType}">
				<!-- 헬스,필라테스,요가 검색시 -->
				<input type="button" value=" 높은가격순"
						style="float: right; background-color: white; border: 0em; color: #7a7ebf"
						onclick="javascript:location.href='<%=cp%>/productList.action?type=1&searchValueCategory=${productType }&searchValueWord=${searchValueWord }&pageNum=${pageNum }';">
					<input type="button" value=" 낮은가격순 |"
						style="float: right; background-color: white; border: 0em; color: #7a7ebf"
						onclick="javascript:location.href='<%=cp%>/productList.action?type=2&searchValueCategory=${productType }&searchValueWord=${searchValueWord }&pageNum=${pageNum }';">
					<input type="button" value="조회수 |"
						style="float: right; background-color: white; border: 0em; color: #7a7ebf"
						onclick="javascript:location.href='<%=cp%>/productList.action?type=3&searchValueCategory=${productType }&searchValueWord=${searchValueWord }&pageNum=${pageNum }';">
				
				</c:if>
				
			</form>

			<br>
			<section class="gallery"> 
			<!-- for문 한칸 --> 
			<c:forEach var="dto" items="${lists }">
				<div class="gallery_item">
					<span class="gallery_item_preview"> 
					<a href="${articleUrl}&productId=${dto.productId}" >
							<img alt="그림" src="${imagePath }/${dto.productImg}" width="250" height="250">
							<h3>${dto.productId}/${dto.productName}</h3>
							<p>${dto.productPrice }원/조회수${dto.productHit }</p>
					</a>
					</span>
				</div>
			</c:forEach> 
			</section>
		</div>
	</div>



	<div align="center" style="width: 100%; height: 350px;">&nbsp;</div>
	<div align="center" style="width: 100%; height: 100px;">
		<!-- 페이징 -->
		<c:if test="${dataCount != 0 }">${pageIndexList }</c:if>
		<c:if test="${dataCount == 0 }">등록된 게시물이 없습니다</c:if>
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