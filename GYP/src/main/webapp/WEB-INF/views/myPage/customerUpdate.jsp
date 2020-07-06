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
		
		f.action = "<%=cp%>/customerDeleted_ok.action";
		f.submit();
	}
</script>


</head>
<body>

	<div class="col-12 col-lg-6" style="position:absolute; left:25%; top:25%";>

		<div class="our-newsletter-area mb-100">
			<div class="section-heading">
				<h6>Fitness Gym</h6>
				<h2>회원정보 수정 </h2>
			</div>

			<form action="" method="post" name="myForm">
				<div class="form-group">
					<input type="" class="form-control" name="cusId" 
						placeholder="아이디" style="width: 400px;" value="${dto.cusId }" readonly="readonly">
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
			
			<%-- 
			<table style="width: 400px" >
			<tr style="text-align: center">
				<td style="padding: 10px;"><a>회원가입</a></td>
				<td style="padding: 10px;"><a href="<%=cp%>/searchid.action">아이디 찾기</a></td>
				<td style="padding: 10px;"><a href="<%=cp%>/searchpw.action">비밀번호 찾기</a></td>
			</tr>
			</table>
			 --%>
			
		</div>
	</div>


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