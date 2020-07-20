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
function sendIt() {

	f = document.myForm;

	str = f.qnaTitle.value;
	str = str.trim();

	if (!str) {
		alert("\n제목을 입력하세요");
		f.qnaTitle.focus();
		return;
	}
	f.qnaTitle.value = str;
	
	str = f.mode.value;
	if(!($('input:radio[name="qnaType"]').is(':checked'))&&(str=="insert")){
		alert("\n질문유형을 선택해주세요");
		return;
	}
	f.mode.value = str;
	
	str = f.qnaContent.value;
	str = str.trim();

	if (!str) {
		alert("\n내용을 입력하세요");
		f.qnaContent.focus();
		return;
	}
	f.qnaContent.value = str;

	if (f.mode.value=="insert")
		f.action = "/gyp/qnaCreated_ok.action";
	else if(f.mode.value=="update")
		f.action = "/gyp/qnaUpdated_ok.action";
	else if(f.mode.value=="reply")
		f.action = "/gyp/qnaReply_ok.action";
	
	f.submit();
}

function qnaTypeCheck(){
	   var chkcount = document.getElementsByName("qnaType").length;
	   
	   for(var i=0;i<chkcount;i++){
	      if(document.getElementsByName("qnaType")[i].checked == true){
	         var qnaTypeChk = document.getElementsByName("qnaType")[i].value;
	         $('input[name=qnaTitle]').attr('value','['+qnaTypeChk+']');
	      }
	   }
	}

</script>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">

	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<!-- 메인 : header_main.jsp / 그외 : header_below.jsp -->
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
<!-- 제목 -->
	<c:if test="${mode=='insert'}">
		<h2>Q&A 등록</h2>
	</c:if>
	<c:if test="${mode=='update'}">
		<h2>Q&A 수정</h2>
	</c:if>
	<c:if test="${mode=='reply'}">
		<h2>Q&A 답글</h2>
	</c:if>

	<br><br>
<!-- 메인 -->
	<form method="post" action="/gyp/qnaCreated.action" name="myForm">

		<table>
			<tr>
				<td>번호</td>
				<td><input type="text" name="qnaNum" value="${dto.qnaNum }" disabled="disabled" /></td>
			</tr>
			<tr>
			<!-- 게시글 작성할 때만 나타나게 하고, 수정/답글할 때는 예전에 작성했던 것들을 불러오기위해. -->
			<c:if test="${mode=='insert'}">	
				<td>질문유형 </td>
				<td>
					<input type="radio" name="qnaType" value="체육관" onclick="qnaTypeCheck()"/>체육관
					<input type="radio" name="qnaType" value="이용권" onclick="qnaTypeCheck()"/>이용권
					<input type="radio" name="qnaType" value="쇼핑몰" onclick="qnaTypeCheck()"/>쇼핑몰
				</td>
			</c:if>	
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="cusId" value="${dto.cusId }" disabled="disabled" /></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="qnaTitle" size="74" maxlength="100" value="${dto.qnaTitle }"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="qnaContent" rows="12" cols="63">${dto.qnaContent }</textarea></td>
			</tr>
		</table>
		<div id="qnaCreated footer">
		<!-- reply필요한 파라미터 -->			
			<input type="hidden" name="qnaGroupNum" value="${dto.qnaGroupNum }"/>
			<input type="hidden" name="qnaOrderNo" value="${dto.qnaOrderNo }"/>
			<input type="hidden" name="qnaDepth" value="${dto.qnaDepth }"/>
			<input type="hidden" name="qnaParent" value="${dto.qnaNum }"/>
		<!-- insert 필요한 파라미터 -->	
			<input type="hidden" name="qnaType" value="${dto.qnaType }"/>
			<input type="hidden" name="mode" value="${mode }"/>
		<!-- update 필요한 파라미터 -->	
			<input type="hidden" name="pageNum" value="${pageNum }"/>
			<input type="hidden" name="qnaNum" value="${dto.qnaNum }" />
			

			<c:if test="${mode=='insert'}">
				<input type="button" value="등록하기" onclick="sendIt();" />
				<input type="button" value="작성취소" onclick="javascript:location.href='/gyp/qnaList.action';" />
			</c:if>

			<c:if test="${mode=='update'}">
				<input type="button" value="수정하기" onclick="sendIt();" />
				<input type="button" value="수정취소" onclick="javascript:location.href='/gyp/qnaList.action';" />
			</c:if>
			
			<c:if test="${mode=='reply'}">
				<input type="button" value="답변하기" onclick="sendIt();" />
				<input type="button" value="작성취소" onclick="javascript:location.href='/gyp/qnaList.action';" />
			</c:if>

		</div>
	</form>

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