<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게 시 판</title>

<link rel="stylesheet" href="/gyp/resources/css/style.css" type="text/css"/>
<link rel="stylesheet" href="/gyp/resources/css/created.css" type="text/css"/>

<script type="text/javascript" src="/gyp/resources/js/util.js"></script>

<script type="text/javascript">
		
		function sendIt(){
			
			f = document.myForm;
			
			str = f.notiTitle.value;
			str = str.trim();
			if(!str){
				alert("\n제목을 입력하세요.");
				f.notiTitle.focus();
				return;
			}
			f.notiTitle.value = str;

			str = f.notiContent.value;
			str = str.trim();
			if(!str){
				alert("\n내용을 입력하세요.");
				f.notiContent.focus();
				return;
			}
			f.notiContent.value = str;
		
		f.action = "<%=cp%>/noticeCreated_ok.action";
		f.submit();
		
	}

</script>

</head>
<body>

<div id="bbs">
	<div id="bbs_title">
	게 시 판(Spring3.0)	
	</div>
	
	<form action="" name="myForm" method="post">
	<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
				<dd>
					<input type="text" name=notiTitle size="74" maxlength="100" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		<!-- 
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>작성자</dt>
				<dd>
					<input type="text" name="name" size="35" maxlength="20" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
 -->	
		<div id="bbsCreated_content" >
			<dl>
				<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
				<dd>
					<textarea rows="12" cols="63" name="notiContent" class="boxTA"></textarea>
				</dd>							
			</dl>		
		</div>
	
	</div>	
	
	<div id="bbsCreated_footer">
	<input type="button" value=" 등록하기 " class="btn2" 
	onclick="sendIt();"/>
	<input type="reset" value=" 다시입력 " class="btn2" 
	onclick="document.myForm.notiTitle.focus();"/>
	<input type="button" value=" 작성취소 " class="btn2" 
	onclick="javascript:location.href='<%=cp%>/noticeList.action';"/>
	</div>
	
	</form>
	
</div>

</body>
</html>
