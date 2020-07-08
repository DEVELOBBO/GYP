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
	
	
<title>GYP에서 GYM하자..</title>
</head>

<script type="text/javascript" src="/springwebmybatis/resources/js/util.js"></script>

<script type="text/javascript">

	function sendIt(){
		
		f = document.myForm;
		
	
		
		f.action = "<%=cp%>/gym_ok.action";
		f.submit();
		
	}
	
	
	
	

</script>


<body>

<div id="bbs">
	<div id="bbs_title">
	체육관 회원가입창★	
	</div>
	
	<form action="" name="myForm" method="post" enctype="multipart/form-data" >
	<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>체육관 아이디</dt>
				<dd>
					<input type="text" name="gymId" size="74" maxlength="100" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>체육관 이름</dt>
				<dd>
					<input type="text" name="gymName" size="35" maxlength="20" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>비밀번호</dt>
				<dd>
					<input type="text" name="gymPwd" size="35" maxlength="20" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>e-mail</dt>
				<dd>
					<input type="text" name="gymEmail" size="35" maxlength="50" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>전화번호</dt>
				<dd>
					<input type="text" name="gymTel" size="35" maxlength="50" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>주소</dt>
				<dd>
					<input type="text" name="gymAddr" size="35" maxlength="50" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>체육관 유형</dt>
				<dd>
				<input type="radio" value="헬스" name="gymType"/>헬스
				<input type="radio" value="요가" name="gymType"/>요가
				<input type="radio" value="필라테스" name="gymType"/>필라테스		
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>트레이너 등록</dt>
				<dd>
				<input type="text"  name="gymTrainer" class="boxTF"/>
				<input type="file"  name="upload" class="boxTF"/>
				</dd>		
				<dd>
				<input type="text"  name="gymTrainer" class="boxTF"/>
				<input type="file"  name="upload" class="boxTF">
				</dd>
				<dd>
				<input type="text"  name="gymTrainer" class="boxTF"/>
				<input type="file"  name="upload" class="boxTF">
				</dd>
				<dd>
				<input type="text"  name="gymTrainer" class="boxTF"/>
				<input type="file"  name="upload" class="boxTF">
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




































