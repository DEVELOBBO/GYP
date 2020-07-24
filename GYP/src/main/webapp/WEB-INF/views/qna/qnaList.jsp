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
	<!-- qna.css -->
	<link rel="stylesheet" href="/gyp/resources/css/qna.css">
	
<title>GYP</title>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<!-- 메인 : header_main.jsp / 그외 : header_below.jsp -->
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
	
	<section class="contact-area section-padding-100">
	<div class="container">
	<div class="row">
	<div class="col-12">
	<div class="contact-title">
		<h5 style="color:#38b143;">FITNESS GYM</h5>
		<h2>Q&A&nbsp;&nbsp;&nbsp;
		<input type="button" style="float: right;" class="btn fitness-btn m-2" value="1:1 문의 남기기" onclick="javascript:location.href='/gyp/qnaCreated.action';"/>
		</h2>
	</div>
	</div>
	</div>
	</div>	
		
		<div class="container">
			<form name="searchForm" method="post">
				<select name="searchValue" style="border: none;">
					<option value="">전체</option>
					<option value="체육관">체육관</option>
					<option value="이용권">이용권</option>
					<option value="쇼핑몰">쇼핑몰</option>				
				</select>
				<input type="text" placeholder="어떤 도움이 필요하세요?" name="searchValue2" 
				style="border: none;">
				<input type="submit" class="fas fa-search"  onclick="sendIt();"
				style="width:42px;height:32px;border: none;background-color:#38b143;color: white;" value="&#xf002;"/>
			</form>
		</div>
		
		<div class="container">
		<div class="row">
		<div class="col-12">
		<div class="contact-form-area">
			<c:forEach var="dto" items="${lists }">
			<hr>
			<div>
				<div>${dto.listNum }</div>
				<div>	
					<c:if test="${dto.qnaDepth!=0}">
						<c:forEach var="i" begin="1" end="${dto.qnaDepth }" step="1">
							&nbsp;
						</c:forEach>
					</c:if>
					<a href="${articleUrl}&qnaNum=${dto.qnaNum}">${dto.qnaTitle }</a>
				</div>	
				<div>${dto.qnaCreated }</div>	
			</div>
			</c:forEach>
			<hr>
		</div></div></div></div>
				
		<div class="container">	
			<c:if test="${dataCount!=0 }">
				${pageIndexList }
			</c:if>
			<c:if test="${dataCount==0 }">
				등록된 게시물이 없습니다.
			</c:if>
		</div>
	</section>		
	

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
<script type="text/javascript">
function sendIt(){
	
	f = document.searchForm;
	f.action="/gyp/qnaList.action";
	f.submit();
}



</script>
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
	<!-- qna.js -->
	<script src="/gyp/resources/js/qna.js"></script>
<!-- fontawesome(검색버튼) -->
	<script src="https://kit.fontawesome.com/4badd96a47.js" crossorigin="anonymous"></script>
</body>
</html>