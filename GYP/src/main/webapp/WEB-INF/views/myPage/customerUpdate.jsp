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
	
<title>GYP</title>

<script type="text/javascript">

	function sendIt(){
		
		f = document.myForm;
		
		if(!f.cusPwd.value){
			alert("패스워드를 입력하세요!");
			f.cusPwd.focus();
			return;
		}
		
		f.action = "<%=cp%>/customerUpdate_ok.action";
		f.submit();
	}
	
	function deletedId(){
		
		f = document.myForm;
		
		if(!f.cusPwd.value){
			alert("패스워드를 입력하세요!");
			f.cusPwd.focus();
			return;
		}
		if(confirm("정말 GYP서비스를 탈퇴하시겠습니까?"))
		{
			alert('그동안 GYP서비스를 이용해 주셔서 감사합니다.');

			//로그인화면으로 이동
			f.action = "<%=cp%>/customerDeleted_ok.action";
			f.submit();
		}
		
	}
	
</script>


</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
	<div style="height: 100px;"></div>
	
	<div style="position: relative;  margin-left: auto; margin-right: auto;">
		<div class="col-12 col-lg-6" style="position:relative; margin-left: auto; margin-right: auto;">
			<div class="our-newsletter-area mb-100" style="" >
				<div class="section-heading">
				<h6>Fitness Gym</h6>
				<h2>회원정보 수정 </h2>
			</div>

			<form action="" method="post" name="myForm">
				<div class="form-group">
					<input type="text" class="form-control" name="cusId" 
						placeholder="아이디" style="width: 400px;" value="${dto.cusId }" >
				</div>
				<div class="form-group mb-0">
					<input type="password" class="form-control" name="cusPwd" 
						placeholder="패스워드" style="width: 400px;">
						<font color="red"><b>${message }</b></font>
				</div>
				
				<button type="button" class="btn fitness-btn btn-white mt-50"
					onclick="deletedId();">회원 탈퇴(임시)</button>
				<button type="button" class="btn fitness-btn btn-white mt-50"
					onclick="sendIt();">비밀번호 수정</button>
			</form>
			<br>
			
		</div>
	</div>
	</div>

<div style="height: 70px;">&nbsp;</div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

 <!-- ##### Footer Area Start ##### -->

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