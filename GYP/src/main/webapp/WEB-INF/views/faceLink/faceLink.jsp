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
	
<title>GYP</title>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />

	<div style="height: 300px;"></div>

<h1 align="center"><div style="width:700px; margin:0 auto;">온라인 PT</div></h1>


<c:if test="${dto == null}">
	<div style="width:500px; margin:0 auto;">
		<img src="/gyp/resources/img/check.png" width="200px"/>
	</div>
	<div>
		수업이 없습니다!
	</div>
		
	
</c:if>

<c:if test="${dto != null }">
	<c:if test="${dto.faceLink == null }">
		<div style="margin:0 auto; width: 600px">
			<div style="width:200px; display:inline;">
				<img src="/gyp/resources/img/check.png" width="200px"/>
			</div>
			<div style="display: inline;">
				준비 중입니다...(수업시작 시간 5분 전에 확인해주세요)
			</div>
		</div>
	</c:if>
	
	<c:if test="${dto.faceLink != null }">
		<div style="width:700px; margin:0 auto;">
		<img src="/gyp/resources/img/check.png" width="200px"/>
		${dto.gymName} ${dto.bookHour} ${dto.gymTrainerPick} 트레이너 수업
		<a target="_blank" href="https://gyp.herokuapp.com/#${dto.faceLink}" style="color: blue;">바로가기</a>
		</div>
		
	</c:if>		
</c:if>

	<div style="height: 300px;"></div>
	

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