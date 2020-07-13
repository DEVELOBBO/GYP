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
<title>GYP</title>

<script type="text/javascript">

	function sendIt(){
		
		f = document.searchForm;
		
		f.action="/gyp/qnaList.action";
		f.submit();
	}
</script>

</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<!-- 메인 : header_main.jsp / 그외 : header_below.jsp -->
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
	
	<div id="">
		<br><br><br>
		<h5>FITNESS GYM</h5><br>
		<h1>WORKING HOURS &nbsp;&nbsp; Q&A</h1>
		<br>
		
		<div id="bbsList_header">
			<div id="leftHeader">
				<form action="/gyp/qnaList.action" name="searchForm" method="post">
					<select name="searchValue" class="selectField">
						<option value="gym">체육관</option>
						<option value="pass">이용권</option>
						<option value="shopping">쇼핑몰</option>				
					</select>
					<input type="text" name="searchValue" class="textField">
					<input type="button" value=" 검색 " class="btn2" onclick="sendIt();"/>			
				</form>		
			</div>
			
			<div id="rightHeader">
				<input type="button" value=" 질문올리기 " class="btn2" 
				onclick="javascript:location.href='/gyp/qnaCreated.action'"/>		
			</div>	
		</div>
				
		<div class="lists">
			<c:forEach var="dto" items="${lists }">
			<div id="lists">
				<dl>
					<dd class="num">${dto.qnaNum }</dd>
					<dd class="subject">
						<a href="${articleUrl}&qnaNum=${dto.qnaNum}">
							${dto.qnaTitle }
						</a>
					</dd>
					<dd class="created">${dto.qnaCreated }</dd>
				</dl>
			</div>	
			</c:forEach>
		</div>
				
		<div id="footer">
		<br>
			<c:if test="${dataCount!=0 }">
				${pageIndexList }
			</c:if>
			<c:if test="${dataCount==0 }">
				등록된 게시물이 없습니다.
			</c:if>
		</div>
			
	</div>

	<div style="height: 70px;">&nbsp;</div>
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