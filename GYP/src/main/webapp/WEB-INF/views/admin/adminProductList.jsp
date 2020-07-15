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
<title>상품 리스트</title>
<link rel="stylesheet" href="/gyp/resources/css/adminProductStyle.css" type="text/css"/>
<link rel="stylesheet" href="/gyp/resources/css/adminProductList.css" type="text/css"/>
<script type="text/javascript">

	function searchData(){

		var f = document.searchForm;		
		f.action = "<%=cp%>/adminProductList.action";
		f.submit();

	}
	
</script>
</head>
<body>
<div id="bbsList">
	<div id="bbsList_title">
	상품 리스트
	</div>

	<div id="bbsList_header">
		<div id="leftHeader">
			<form action="" name="searchForm" method="post">
				<select name="searchKey" class="selectField">
					<option value="productId">상품 ID</option>
					<option value="productName">상품 이름</option>
				</select>
				<input type="text" name="searchValue" class="textField">
				<input type="button" value=" 검색 " class="btn2" onclick="searchData();"/>			
			</form>		
		</div>

		<div id="rightHeader">
			<input type="button" value=" 상품등록 " class="btn2"
			onclick="javascript:location.href='<%=cp%>/adminProductCreated.action';"/>		
		</div>

	</div>

	<div id="bbsList_list">
		<div id="title">
			<dl>
				<dt class="productId">상품 ID</dt>
				<dt class="productName">상품 이름</dt>
				<dt class="productPrice">가격</dt>
				<dt class="productContent">설명</dt>
				<dt class="productImg">사진</dt>
				<dt class="productHit">조회수</dt>
			</dl>
		</div>

		<div id="lists">
		<c:forEach var="dto" items="${lists}">
			<dl>
				<dd class="productId">${dto.productId }</dd> 
				<dd class="productName"><a href="${urlArticle }adminProductArticle.action?productId=${dto.productId }">${dto.productName}</a></dd>
				<dd class="productPrice">${dto.productPrice }</dd>
				<dd class="productContent">${dto.productContent }</dd>
				<dd class="productImg"><a href="${urlArticle }adminProductArticle.action?productId=${dto.productId }"><img src="${imgPath}/${dto.productImg }" width="100" height="100"></a></dd>
				<dd class="productHit">${dto.productHit }</dd>
				
			</dl>
		</c:forEach>
		</div>

		<div id="footer">

			<p>
				<c:if test="${dataCount!=0 }">
					${pageIndexList }
				</c:if>
				<c:if test="${dataCount==0 }">
					등록된 회원이 없습니다.
				</c:if>
			</p>
		</div>	
	</div>
</div>
</body>
</html>