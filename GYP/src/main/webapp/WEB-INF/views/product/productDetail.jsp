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
	<link rel="stylesheet" href="/gyp/resources/css/productDetail.css" type="text/css">

	<!-- js -->
	<script type="text/javascript">
	
	function onlyNumber(event){
	    event = event || window.event;
	    var keyID = (event.which) ? event.which : event.keyCode;
	    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
	        return;
	    else
	        return false;
	}
	 
	function removeChar(event) {
	    event = event || window.event;
	    var keyID = (event.which) ? event.which : event.keyCode;
	    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
	        return;
	    else
	        event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
	
	function sendIt() {
	
	var f = document.myForm;
	
	//비로그인 시 로그인 창으로
	<c:if test="${empty sessionScope.customInfo.sessionId }">
	alert("\n로그인 해주세요")
	location.href = "/gyp/login.action";
	return;
	</c:if>
	
	<%-- if (${sessionScope.customInfo }==null) {
		f.action = "<%=cp%>/fatale/login.do";
		f.submit();
		return;
	} --%>
	
	//수량 빈칸 체크
	str = f.count.value;
	str = str.trim();
	if (!str) {
		alert("\n수량을 입력하세요.");
		f.count.focus();
		return;
	}
	f.count.value = str;	
	
		
	alert("장바구니에 상품이 담겼습니다.");
	
	f.action = "<%=cp%>/productDetail_ok.action?productId=${dto.productId}&pageNum=${pageNum}";
	f.submit();

	}
	</script>

<title>GYP</title>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />


	<div class="wrapper" style="font-family: 'Noto Sans KR', sans-serif;">
		<div class="wrapper_inner">
			<!-- Gallery -->
			<font color="#7a7ebf" size="3pt">&nbsp;&nbsp;상품코드 -
				${dto.productId } | 조회수 - ${dto.productHit } </font>
			<section class="gallery">


			<div class="gallery_item">


				<div class="gallery_article gallery_item_preview">

					<a href="${imagePath }/${dto.productImg}"> <img alt="그림"
						src="${imagePath }/${dto.productImg}" width="250" height="250"></a>

				</div>


				<div class="article_item">
					<form action="" name="myForm" method="post">
						<!-- 제목 -->

						<font size="4pt" color="#BDBDBD">상품코드&nbsp;${dto.productId}&nbsp;
						</font><br> <font style="font-size: 35pt" color="black">${dto.productName}</font>
						<br>
						<hr>

						<!-- 가격 -->
						<font size="6pt" color="#2E338C">${dto.productPrice }원&nbsp;</font>


						<font size="4pt">&nbsp;|&nbsp;조회:${dto.productHit }</font>

						<!-- 옵션 -->
						<br>
						<br>
						<br> <input type="hidden" name="pid"
							value="${dto.productId }" />
						<!-- 갯수 선택 -->
						<!-- 수량 -->
						<font style="font-size:16pt; color: #666; vertical-align: middle;">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						갯수&nbsp;&nbsp;</font>
						<input type="text" name="count" 
						style="width: 50px; height: 45px; padding-top: 2px; text-align: center;
						color:#F23D4C; font-size: 20pt; vertical-align: middle;" 
						onkeydown ='return onlyNumber(event)' onkeyup ='removeChar(event)'>
						<br>
						<br>
						<hr>
						<br>
						<!-- 버튼 -->
						<input type="button" class="btn fitness-btn btn-white mt-10"
							style="min-width: 100px;" value=" 장바구니 " onclick="sendIt();" /> <input
							type="button" class="btn fitness-btn btn-white mt-10"
							style="min-width: 100px;" value=" 구매하기" onclick="byenow();" /> <br>
						<br>


						<!-- 상품설명 -->

						<font size="4px" color="#8C8C8C">&nbsp;${dto.productContent }&nbsp;</font>


						<!-- 리뷰보기 -->

						<input type="button" onclick="" value="리뷰 보기"
							class="bokyung_review"><br> <br>
						<br> <input type="button" class="bokyung_back" value="◀목록으로"
							onclick="javascript:location.href='<%=cp%>/productList.action?searchKey=${searchKey }&searchValue=${searchValue }&pageNum=${pageNum }';" />

					</form>
				</div>
			</div>
			</section>
		</div>
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