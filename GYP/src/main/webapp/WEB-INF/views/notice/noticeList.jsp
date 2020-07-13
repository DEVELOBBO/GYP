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
	
	
	<style type="text/css">
	#noticeList{
		width:500px;
		height:800px;
		margin:30px auto;
		text-align:center;
	}
	h5{
		color:green;
		text-align:left;
	}
	#noticeList_title{
		width:664px;   /* 690px - (padding-left+border:3px+border:3px) */
		padding-left:20px;
		height:40px;
		text-align:left;
		font-weight: bold;
		line-height:40px;
		font-size:30pt;
		margin-bottom:30px;
	}
	
	#noticeList_list #right{
		float:right;
		width:345px;
		text-align:right;
	}
	hr{}

	td{
		width: 500px;
		margin: auto;
	}
	
	</style>
		
	
	
<title>GYP</title>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<!-- 메인 : header_main.jsp / 그외 : header_below.jsp -->
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
	
	
	<div id="noticeList">
		<br><br>
		<h5>FITNESS GYM</h5>
		<div id="noticeList_title">WORKING HOURS &nbsp;&nbsp; 공지사항</div>
		<br>
		<a href=/gyp/noticeCreated.action>테스트용 글올리기</a>		
		
		<div>
			<c:forEach var="dto" items="${lists }">
			<div id="lists">
				<table>
					<tr>
					<td>${dto.listNum }</td>
					<td>
						<a href="${articleUrl}&notiNum=${dto.notiNum}">
							${dto.notiTitle }
						</a>
					</td>
					<td id="right">${dto.notiCreated }</td>
					</tr>
				</table>
			</div>	
			</c:forEach>
		
				
			<div>
				<c:if test="${dataCount!=0 }">
					${pageIndexList }
				</c:if>
				<c:if test="${dataCount==0 }">
					등록된 게시물이 없습니다.
				</c:if>
			</div>
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