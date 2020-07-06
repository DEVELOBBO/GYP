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
	function search() {
		
		var f = document.myForm;
		
		if(!f.cusName.value){
			alert("이름를 입력하세요!");
			f.cusName.focus();
			return;
		}
		if(!f.cusTel.value){
			alert("전화번호를 입력하세요!");
			f.cusTel.focus();
			return;
		}
		
		f.action = "<%=cp%>/searchid_ok.action";
		f.submit();
		
	}

</script>

</head>
<body>


<div class="col-12 col-lg-6" style="position:absolute; left:25%; top:25%";>

		<div class="our-newsletter-area mb-100" >
			<div class="section-heading">
				<h6>Fitness Gym</h6>
				<h2>아이디 찾기</h2>
			</div>

			<form action="" method="post" name="myForm">
				<div class="form-group">
					<input type="text" class="form-control" name="cusName" id="name"
						placeholder="이름" style="width: 400px;">
				</div>
				<div class="form-group mb-0">
					<input type="text" class="form-control" name="cusTel" id="name"
						placeholder="휴대전화" style="width: 400px;">
					<font color="red"><b>${message }</b></font>
				</div>
				<button type="button" class="btn fitness-btn btn-white mt-50"
					onclick="javascript:location.href='<%=cp%>/login.action';">뒤로가기</button>
				<button type="button" class="btn fitness-btn btn-white mt-50"
					onclick="search();">아이디 찾기</button>
			</form>
			
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