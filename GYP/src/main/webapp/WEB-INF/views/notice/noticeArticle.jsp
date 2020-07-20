<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Favicon -->
<link rel="icon" href="/gyp/resources/img/core-img/favicon.ico">
<!-- Core Stylesheet -->
<link rel="stylesheet" href="/gyp/resources/css/style.css">
<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
<!-- notice.css -->
<link rel="stylesheet" href="/gyp/resources/css/notice.css">
<title>GYP</title>
<script type="text/javascript">
function deleteData(){
	
	var notiNum = "${dto.notiNum}";
	var pageNum = "${pageNum}";
	var params = "?notiNum=" + notiNum + "&pageNum=" + pageNum;
	var url = "<%=cp%>/noticeDeleted.action" + params;
	
	location.replace(url);
	
}

function updateData(){
	
	var notiNum = "${dto.notiNum}";
	var pageNum = "${pageNum}";
	var params = "?notiNum=" + notiNum + "&pageNum=" + pageNum;
	var url = "<%=cp%>/noticeUpdated.action" + params;
	
	location.replace(url);
	
}


</script>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">

	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<!-- 메인 : header_main.jsp / 그외 : header_below.jsp -->
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />

	<div id="noticeList">
		<br>
		<br>
		<br>
		<h5>FITNESS GYM</h5>
		<div id="noticeList_title">WORKING HOUR &nbsp;&nbsp; 공지사항</div>
		<br>

		<div>
			<div id="noticeList_list">
				<dl>
					<dt>제목: ${dto.notiTitle }</dt>
					<dt>이름 : 대표관리자</dt>
					<dt>작성일: ${dto.notiCreated }</dt>
				</dl>
			</div>
			<div id="lists">
				<table width="600" border="0">
					<tr>
						<td style="padding: 20px 80px 20px 62px;" valign="top" height="200">${dto.notiContent }</td>
					</tr>
				</table>
			</div>
		</div>
		<div>
			이전글:
			<c:if test="${!empty preNotiTitle  }">
				<a href="<%=cp%>/noticeArticle.action?pageNum=${pageNum }&notiNum=${preNotiNum}">${preNotiTitle }</a>
			</c:if>
		</div>

		<div>
			다음글:
			<c:if test="${!empty nextNotiTitle  }">
				<a href="<%=cp%>/noticeArticle.action?pageNum=${pageNum }&notiNum=${nextNotiNum}">${nextNotiTitle }</a>
			</c:if>
		</div>
		<br>


		<div id="noticeArticle_footer">
			<div id="leftFooter">
			<!-- 마이페이지에서 다 수정/삭제버튼 설정해놓을거 같아서, 지워도 된다.   -->
			
			<c:if test="${sessionScope.customInfo.sessionId =='admin' }">
			<input type="button" value="수정" class="btn2" onclick="updateData();">
			<input type="button" value="삭제" class="btn2" onclick="deleteData();">
			</c:if>
			</div>  
				<input type="button" value="목록" onclick="javascript:location.href='<%=cp%>/noticeList.action?pageNum=${pageNum }';" />
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
	<!-- notice.js -->
	<script src="/gyp/resources/js/notice.js"></script>
</body>
</html>