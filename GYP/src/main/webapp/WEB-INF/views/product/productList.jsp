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
	
	
	<div class="blog-area mt-20 section-padding-100"> 
		<div class="container">
			<!-- 제목 -->
			<div class="col-12">
				<h5 style="color:#38b143;">SPORTING GOODS</h5>
				<h2 style="display: inline-block;">스포츠용품</h2>
				<button onclick="location.href='/gyp/cart.action'" class="btn fitness-btn btn-white" style="float: right; display: inline-block; border:none; font-size: 17px;">장바구니 바로가기</button>
				<div style="height: 10px;"></div>
				<hr style="margin: 0;"><br/>
			</div>
			
			<!-- 검색 및 정렬 -->
			<div class="col-12">
				<form action="" method="get" name="searchForm" class="form-signin">
					<select name="searchValueCategory" id="searchKey" class="selectField form-control" style="width:130px; height:34px; display: inline-block;">
						<option value="all"  <c:if test="${searchValueCategory eq 'all'}">selected</c:if>>전체</option>
						<option value="H" <c:if test="${searchValueCategory eq 'H'}">selected</c:if>>헬스</option>
						<option value="Y" <c:if test="${searchValueCategory eq 'Y'}">selected</c:if>>요가</option>
						<option value="P" <c:if test="${searchValueCategory eq 'P'}">selected</c:if>>필라테스</option>
						<!-- <option value="prod_price">가격</option> -->
					</select>&nbsp;
					<input type="text" name="searchValueWord" class="textField form-control" value="${searchValueWord }" id="searchValue" 
					style="display: inline-block; height:34px; "/>&nbsp;
					<input type="button" value="검 색" class="btn2 form-control" onclick="search();" 
					style="width: 70px; display: inline-block; height:35px; margin-bottom: 1px; font-weight: bold; font-family: 'Noto Sans KR', sans-serif;" />
				</form>
				
				<div style="height: 20px;"></div>
				
				<form action="" method="get" name="orderby" class="form-signin">
					
					<font color="gray">총 상품 ${dataCount }개, <font color="#38b143">현재 ${currentPage } 페이지</font> / ${totalPage } 페이지</font>
					
					<c:if test="${empty productType2}">
						<input type="button" value=" 높은가격순" 
							style="float: right; background-color: white; border: 0em; color: gray" 
							onclick="javascript:location.href='<%=cp%>/productList.action?type=1&searchValueCategory=${searchValueCategory }&searchValueWord=${searchValueWord }&pageNum=${pageNum }';">
						<input type="button" value=" 낮은가격순 |"
							style="float: right; background-color: white; border: 0em; color: gray"
							onclick="javascript:location.href='<%=cp%>/productList.action?type=2&searchValueCategory=${searchValueCategory }&searchValueWord=${searchValueWord }&pageNum=${pageNum }';">
						<input type="button" value="조회수 |"
							style="float: right; background-color: white; border: 0em; color: gray"
							onclick="javascript:location.href='<%=cp%>/productList.action?type=3&searchValueCategory=${searchValueCategory }&searchValueWord=${searchValueWord }&pageNum=${pageNum }';">
					</c:if>
					
					<c:if test="${!empty productType2}">
					<!-- 헬스,필라테스,요가 검색시 -->
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
				</form>
			</div> 
			
			<!-- 상품 리스트 -->
			<div class="col-12 mt-30 mb-30" style="height: auto;">
				<div class="gallery">
				<!-- for문 한칸 --> 
				<c:forEach var="dto" items="${lists }">
					<div class="gallery_item col-3"> <!--  style="float: none;" -->
						<span class="gallery_item_preview"> 
						<a href="${articleUrl}&productId=${dto.productId}" >
								<img alt="그림" src="${imagePath }/${dto.productImg}" style="width: 220px; height: 220px;" > 
								<h4>${dto.productId}/${dto.productName}</h4>
								<p>${dto.productPrice }원/조회수${dto.productHit }</p>
						</a>
						</span>
					</div>
				</c:forEach>
				<div style="clear: both;"></div> 
				</div> 
				<!-- 페이징 -->
				<div align="center" style="width: 100%; height: 350px;">&nbsp;</div>
				<div align="center" style="width: 100%; height: 100px;">
					<!-- 페이징 -->
					<c:if test="${dataCount != 0 }">${pageIndexList }</c:if>
					<c:if test="${dataCount == 0 }">등록된 게시물이 없습니다</c:if>
				</div>  
			</div> 
		
		</div>
	</div>
	<!-- <div class="wrapper"></div> -->

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