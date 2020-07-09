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
	<!-- 플로팅 -->
	<link rel="stylesheet" href="/gyp/resources/css/floating.css">
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
	
<title>GYP</title>
<script type="text/javascript">

	function deleteData(){
		
		var notiNum = "${dto.notiNum}";
		var pageNum = "${pageNum}";
		var params = "?notiNum=" + notiNum + "&pageNum=" + pageNum;
		var url = "/gyp/noticeDeleted.action" + params;
		
		location.replace(url);
		
	}
	
	function updateData(){
		
		var notiNum = "${dto.notiNum}";
		var pageNum = "${pageNum}";
		var params = "?notiNum=" + notiNum + "&pageNum=" + pageNum;
		var url = "/gyp/noticeUpdated.action" + params;
		
		location.replace(url);
		
	}


</script>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/floating.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<!-- 메인 : header_main.jsp / 그외 : header_below.jsp -->
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />

	<script type="text/javascript">
	
	function sendIt(){
		
		f = document.myForm;
		
		str = f.notiTitle.value;
		str = str.trim();
		
		if(!str){
			alert("\n제목을 입력하세요");
			f.notiTitle.focus();
			return;			
		}
		f.notiTitle.value = str; 
	
		
		str = f.notiContent.value;
		str = str.trim();
		
		if(!str){
			alert("\n내용을 입력하세요");
			f.notiContent.focus();
			return;			
		}
		f.notiContent.value = str; 
		
		if(f.mode.value=="insert")
			f.action = "/gyp/noticeCreated_ok.action";
		else
			f.action = "/gyp/noticeUpdated_ok.action";	
		f.submit();
		
		
	}
</script>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<c:if test="${mode=='insert'}">
	<h2>공지사항 등록</h2>
	</c:if>
	
	<c:if test="${mode=='update'}">
	<h2>공지사항 수정</h2>
	</c:if>
		
	<br><br>
	
	<form method="post" action="/notice/noticeCreated.action" name="myForm">
	
	<table>
		<tr>
			<td>번호</td>
			<td><input type="text" name="notiNum" size="74" maxlength="100" value="${dto.notiNum }" disabled="disabled"/></td>
		</tr>
	<%-- 	<tr>
			<td>작성자</td>
			<td><input type="text" name="productName" size="74" maxlength="100" value="${productName }"/></td>
		</tr>
	 --%>	
	
		
		<tr>
			<td>제목</td>
			<td><input type="text" name="notiTitle" size="74" maxlength="100" value="${dto.notiTitle }"/></td>
		</tr>
		
		<tr>
			<td>내용</td>
			<td><textarea name="notiContent" rows="12" cols="63" >${dto.notiContent }</textarea></td>
		</tr>
	</table>
	<div id="notiCreated footer">
	<input type="hidden" name="mode" value="${mode }" />
					
		<c:if test="${mode=='update'}">
		<input type="hidden" name="notiNum" value="${dto.notiNum }"/>
		</c:if>
		<input type="hidden" name="pageNum"	value="${pageNum }"/>
					
		<c:if test="${mode=='insert'}">
		<input type="button" value="등록하기"  onclick="sendIt();"/>
		<input type="button" value ="작성취소" 
		onclick="javascript:location.href='/gyp/noticeList.action';"/>
		</c:if>
					
		<c:if test="${mode=='update'}">
		<input type="button" value="수정하기"  onclick="sendIt();"/>
		<input type="button" value ="수정취소"
		onclick="javascript:location.href='/gyp/noticeList.action';"/>
		</c:if>
					
	</div>
	</form>
	
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