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
	<meta http-equiv="refresh" content="60; URL=/gyp/gymMyPage.action">
	<!-- Favicon -->
	<link rel="icon" href="/gyp/resources/img/core-img/favicon.ico">
	<!-- Core Stylesheet -->
	<link rel="stylesheet" href="/gyp/resources/css/style.css">
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
	
	<!-- 마이페이지 -->
	<link rel="stylesheet" href="/gyp/resources/css/myPage.css">

<title>GYP</title>

<script type="text/javascript">
   
      function toUpdate(){
         
            f = document.myForm;
         
            var str = f.gymPwd.value;
            var ck = f.gymPwdck.value;
            
            str = str.trim();
            
            if(!str){
                alert("\n비밀번호를 입력하세요!");
                f.gymPwd.focus();
                return;
             }
            
            if(str!=ck){
               alert("\n비밀번호가 일치하지 않습니다.");
               f.gymPwd.focus();
               return;
            }
             
            f.gymPwd.value = str;
             
            f.action = "<%=cp%>/gymUpdate.action";
			f.submit();
	}

</script>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />


<div id="myPage_wrapper" style="font-family: 'Noto Sans KR', sans-serif;">
		<div id="content">
			<h5 style="color: green;">GYM MY PAGE</h5>
			<h2 class="mb-30">마이 페이지</h2>

			<!-- 회원정보 -->
			<div class="containter" id="1">

				<span class="mp_title" style="font-size: 19px;">체육관 정보</span>
				<table class="table01" border="0" cellpadding="10" cellspacing="10" style="padding: 2em;">
					<tr style="text-align: center; border-spacing: 120px;"  >
						<th style="font-size: 20px;" >아이디</th>
						<td style="text-align: left;">${gymdto.gymId }</td>
					</tr>
					<tr style="text-align: center; border-spacing: 120px;"  >
						<th style="font-size: 20px;" >타입</th>
						<td style="text-align: left;">${gymdto.gymType}</td>
					</tr>
					<tr style="text-align: center">
						<th style="font-size: 20px;" >이름</th>
						<td style="text-align: left;">${gymdto.gymName }</td>
					</tr>
					<tr style="text-align: center; border-spacing: 120px;"  >
						<th style="font-size: 20px;" >이메일</th>
						<td style="text-align: left;">${gymdto.gymEmail }</td>
					</tr>
					<tr style="text-align: center">
						<th style="font-size: 20px;" >연락처</th>
						<td style="text-align: left;">${gymdto.gymTel }</td>
					</tr>
					<tr style="text-align: center">
						<th style="font-size: 20px;" >주소</th>
						<td style="text-align: left;">${gymdto.gymAddr }&nbsp;${gymdto.gymAddrDetail }</td>
					</tr>
				</table>

				<div class="right_float">
					<form action="" name="myForm">
						<input type="hidden" name="gymPwdck" value=${gymdto.gymPwd }>
						비밀번호 입력: &nbsp; <input type="password" name="gymPwd"
							class="bokyung_mypage_text" />&nbsp;&nbsp; 
							<input type="button"
							value="회원정보 수정" onclick="javascript:toUpdate()"
							class="btn fitness-btn btn-white mt-10" style="min-width: 50px;"/>
					</form>
				</div>

			</div>

			<br>
			<br>

			<div class="container" id="2">
				<span class="mp_title">누적 매출</span>
				<table class="table01" border="0" cellpadding="10" cellspacing="10">
					<tr>
						<td><font color="blue" size="5">
						<a href="gymMyPage.action?year=${preYear}&month=${preMonth}">◀</a>		<!-- 왼쪽 화살표를 눌러도 자기 자신의 페이지가 떠야함 -->
						<b>&nbsp;${year }년&nbsp;&nbsp;${month }월</b>
						<a href="gymMyPage.action?year=${nextYear }&month=${nextMonth }">▶</a>
						&nbsp;&nbsp;얻은 패스: ${bookdataCount * gymdto.gymPass}
						</font></td>
					</tr>
				</table>
		

			<br>
			<br>
			<!-- 예약 -->
			<div class="container" id="3">
				<span class="mp_title">예약현항</span>
				<table class="table01" border="0" cellpadding="10" cellspacing="10">
					<tr style="text-align: center">
						<th width="70">번호</th>
						<th style="">예약타입</th>
						<th width="180">회원</th>
						<th width="180">트레이너</th>
						<th width="200">등록일</th>
						<th colspan="2">&nbsp;게시글 관리</th>
					</tr>

					<c:forEach var="bookdto" items="${ gymbooklists }">
						<tr class="tr_white" style="text-align: center;">
							<td>${bookdto.bookNum }</td>
							<td>${bookdto.bookType }</td>
							<td>${bookdto.cusId }</td>
							<td>${bookdto.gymTrainerPick }</td>
							<td>${bookdto.bookCreated }</td>
							<td style="text-align: center;"><a href="https://gyp.herokuapp.com/#${bookdto.faceLink}" class="bokyung_mypage_link">수업하기</a></td>
							<td style="text-align: left;"><a
								href="<%=cp %>/bookDelete.action?bookNum=${bookdto.bookNum}&gymPass=${gymdto.gymPass}&cusId=${bookdto.cusId}"
								class="bokyung_mypage_link_D">거절</a></td>
						</tr>
					</c:forEach>
				</table>
				<div class="check">
					<c:if test="${empty gymbooklists }">
               등록된 예약이 없습니다.
            </c:if>
				</div>
			</div>


			<br>
			<br>
			<!-- 리뷰 -->
			<div class="container" id="4">
				<span class="mp_title">리뷰</span>
				<table class="table01" border="0" cellpadding="10" cellspacing="10">
					<tr style="text-align: center;">
						<th width="70">리뷰번호</th>
						<th width="180">회원</th>
						<th width="170">등록일</th>
						<th width="170">평점</th>
						<th>내용</th>
						<th colspan="2" align="left">&nbsp;게시글 관리</th>
					</tr>

					<c:forEach var="reviewdto" items="${gymreviewlists }">
						<tr class="tr_white" style="text-align: center;">
							<td align="center">${reviewdto.reNum }</td>
							<td>${reviewdto.cusId }</td>
							<td>${reviewdto.reCreated }</td>
							<td>${reviewdto.star }</td>
							<td width="350" style="padding-right: 20px">${reviewdto.reContent }</td>
							<td><a href="" class="bokyung_mypage_link">답변달기(임시)</a></td>
						</tr>
					</c:forEach>
				</table>
				<div class="check">
					<c:if test="${empty gymreviewlists }">
               등록된 리뷰 게시물이 없습니다.
            </c:if>
				</div>
			</div>

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