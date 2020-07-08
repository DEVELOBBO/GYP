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
	<link rel="stylesheet" href="./gyp/resources/css/style.css">
	
	
<title>GYP</title>
</head>

<script type="text/javascript" src="/springwebmybatis/resources/js/util.js"></script>

<script type="text/javascript">

	function sendIt(){
		
		f = document.myForm;
		
	
		
		f.action = "<%=cp%>/customer_ok.action";
		f.submit();
		
	}

</script>


<body>

<div id="bbs">
	<div id="bbs_title">
	개인회원 회원가입창☆	
	</div>
	
	<form action="" name="myForm" method="post">
	<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>아&nbsp;&nbsp;이&nbsp;&nbsp;디</dt>
				<dd>
					<input type="text" name="cusId" size="74" maxlength="100" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이름</dt>
				<dd>
					<input type="text" name="cusName" size="35" maxlength="20" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>패스워드</dt>
				<dd>
					<input type="text" name="cusPwd" size="35" maxlength="50" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이메일</dt>
				<dd>
					<input type="text" name="cusEmail" size="35" maxlength="50" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>전화번호</dt>
				<dd>
					<input type="text" name="cusTel" size="35" maxlength="50" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>주소</dt>
				<dd>
					<input type="text" name="cusAddr" size="35" maxlength="50" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		
	
	</div>	
	
	<div id="bbsCreated_footer">
	<input type="button" value=" 등록하기 " class="btn2" 
	onclick="sendIt();"/>
	<input type="reset" value=" 다시입력 " class="btn2" 
	onclick="document.myForm.cusId.focus();"/>
	<input type="button" value=" 작성취소 " class="btn2" 
	onclick="javascript:location.href='<%=cp%>/list.action';"/>	
	</div>
	
	</form>
	
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




































