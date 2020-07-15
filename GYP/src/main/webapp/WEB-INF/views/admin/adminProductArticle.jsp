<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항</title>

<link rel="stylesheet" href="/gyp/resources/css/style.css" type="text/css"/>
<link rel="stylesheet" href="/gyp/resources/css/list.css" type="text/css"/>

</head>
<body>

<div id="bbs">
	<div id="bbs_title">
	공지사항
	</div>
	<div id="bbsArticle">
		<div id="bbsArticle_header">
			${dto.productId }
		</div>

		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>상품 이름</dt>
				<dd>${dto.productName }</dd>
				<dt>가격</dt>
				<dd>${dto.productPrice }</dd>
			</dl>		
		</div>

		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>조회수</dt>
				<dd>${dto.productHit }</dd>
			</dl>		
		</div>
		
		<div id="bbsArticle_content">
			<table width="600" border="0">
			<tr><td><img src="${imgPath}/${dto.productImg }" width="400" height="400">${dto.productImg }</td></tr>
			<tr><td style="padding: 20px 80px 20px 62px;" valign="top" height="200">
			${dto.productContent }
			</td></tr>		
			</table>			
		</div>	
	</div>

	<div id="bbsArticle_footer">
	
		<div id="leftFooter">	
		
		<input type="button" value=" 수정 " class="btn2" 
		onclick="javascript:location.href='<%=cp%>/adminProductUpdated.action?productId=${dto.productId}&pageNum=${pageNum}'"/>
		<input type="button" value=" 삭제 " class="btn2" 
		onclick="javascript:location.href='<%=cp%>/adminProductDeleted.action?productId=${dto.productId}&pageNum=${pageNum}'"/>
		</div>		
		<div id="rightFooter">
		<input type="button" value=" 리스트 " class="btn2" 
		onclick="javascript:location.href='<%=cp%>/adminProductList.action'"/>
		</div>	
		
	</div>
</div>

</body>
</html>
