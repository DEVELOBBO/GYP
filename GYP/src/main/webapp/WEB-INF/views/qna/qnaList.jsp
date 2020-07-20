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
<script type="text/javascript">
function search(){
	
	f = document.searchForm;
	f.action="/gyp/qnaList.action";
	f.submit();
}

function create(){
	
	f = document.searchForm;
	
	<c:if test="${empty sessionScope.customInfo.sessionId }">
		alert("로그인 해주세요");
		f.action = "/gyp/login.action";
		f.submit();
	</c:if>
	
	<c:if test="${!empty sessionScope.customInfo.sessionId }">
		f.action="/gyp/qnaCreated.action";
		f.submit();
	</c:if>
}

</script>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<!-- 메인 : header_main.jsp / 그외 : header_below.jsp -->
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
	
	<div id="qnaList">
		<br><br>
		<h5>FITNESS GYM</h5>
		<div id="qnaList_title">WORKING HOURS &nbsp;&nbsp; Q&A</div>
		<br>
		
		<div>
			<div>
				<form name="searchForm" method="post">
					<select name="searchValue">
						<option value="">전체</option>
						<option value="체육관">체육관</option>
						<option value="이용권">이용권</option>
						<option value="쇼핑몰">쇼핑몰</option>				
					</select>
					<input type="text" name="searchValue2">
					<input type="button" value="검색" onclick="search();"/>			
				</form>		
			</div>
			
			<div id="rightHeader">
				<input type="button" value="질문올리기" class="btn2" onclick="create();"/>		
			</div>
			
		<c:if test="${result==1}">
		
		</c:if>		
		</div>
				
		<div class="qnaList_list">
			<c:forEach var="dto" items="${lists }">
			<hr>
			<div>
				<table>
					<tr>
					<td>${dto.listNum }</td>
					<td>
						<c:if test="${dto.qnaDepth!=0}">
							<c:forEach var="i" begin="1" end="${dto.qnaDepth }" step="1">
								&nbsp;
							</c:forEach>
						</c:if>
						<a href="${articleUrl}&qnaNum=${dto.qnaNum}">${dto.qnaTitle }</a>
					</td>
					<td id="right">${dto.qnaCreated }</td>
					</tr>
				</table>
			</div>
			</c:forEach>
			<hr>
		</div>
				
		<div id="qnaList_footer">
			<c:if test="${dataCount!=0 }">
				${pageIndexList }
			</c:if>
			<c:if test="${dataCount==0 }">
				등록된 게시물이 없습니다.
			</c:if>
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
	<!-- qna.js -->
	<script src="/gyp/resources/js/qna.js"></script>

</body>
</html>