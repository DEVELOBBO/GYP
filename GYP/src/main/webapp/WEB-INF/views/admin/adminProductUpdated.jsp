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
<title>상품 수정</title>

<link rel="stylesheet" href="/gyp/resources/css/style.css" type="text/css"/>
<link rel="stylesheet" href="/gyp/resources/css/created.css" type="text/css"/>

<script type="text/javascript" src="/gyp/resources/js/util.js"></script>

<script type="text/javascript">
	
	function sendIt(){
		
		f = document.myForm;
		
		str = f.productName.value;
		str = str.trim();
		if(!str){
			alert("\n상품 이름을 입력하세요.");
			f.productName.focus();
			return;
		}
		f.productName.value = str;

		str = f.productPrice.value;
		str = str.trim();
		if(!str){
			alert("\n상품 가격을 입력하세요.");
			f.productPrice.focus();
			return;
		}
		f.productPrice.value = str;
		
		str = f.productContent.value;
		str = str.trim();
		if(!str){
			alert("\n상품 내용을 입력하세요.");
			f.productContent.focus();
			return;
		}
		f.productContent.value = str;
			
		f.action = "<%=cp%>/adminProductUpdated_ok.action";
		f.submit();
		
	}

</script>

</head>
<body>

<div id="bbs">
	<div id="bbs_title">
	상품 수정
	</div>
	
	<form action="" name="myForm" method="post">
	<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>상품 ID</dt>
				<dd>
					<input type="text" readonly="readonly" name=productId value="${dto.productId }" size="74" maxlength="100" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>상품 이름</dt>
				<dd>
					<input type="text" name="productName" value="${dto.productName }" size="35" maxlength="20" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>상품 이미지</dt>
				<dd>
					<input type="file" name="productImg" value="${dto.productImg }" size="35" maxlength="20" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
	
		<div id="bbsCreated_content" >
			<dl>
				<dt>상품 가격</dt>
				<dd>
					<input type="text" name="productPrice" value="${dto.productPrice }" size="35" maxlength="20" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>상품 설명(내용)</dt>
				<dd>
					<input type="text" name="productContent" value="${dto.productContent }" size="35" maxlength="20" class="boxTF"/>
				</dd>							
			</dl>		
		</div>
	
	</div>	
	
	
	
	<div id="bbsCreated_footer">
		
		<input type="hidden" name="pageNum" value="${pageNum }"/>
		
		<input type="button" value=" 수정하기 " class="btn2" 
		onclick="sendIt();"/>
		
		<input type="reset" value=" 다시입력 " class="btn2" 
		onclick="document.myForm.productId.focus();"/>
		
		<input type="button" value=" 수정취소 " class="btn2" 
		onclick="javascript:location.href='<%=cp%>/adminProductList.action';"/>
		
		</div>
	
	</form>
	
</div>

</body>
</html>
