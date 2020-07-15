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
<title>회원 리스트</title>
<link rel="stylesheet" href="/gyp/resources/css/adminCustomerStyle.css" type="text/css"/>
<link rel="stylesheet" href="/gyp/resources/css/adminCustomerList.css" type="text/css"/>

<script type="text/javascript">

	function sendIt(){

		var f = document.searchForm;		
		f.action = "<%=cp%>/customerList.action";
		f.submit();

	}
</script>
</head>
<body>

<div id="bbsList">

	<div id="bbsList_title">
	회원 리스트
	</div>

	<div id="bbsList_header">
		<div id="leftHeader">
			<form action="" name="searchForm" method="post">
				<select name="searchKey" class="selectField">
					<option value="cusid">아이디</option>
					<option value="cusname">이름</option>
					<!-- <option value="번호">번호</option> -->
				</select>
				<input type="text" name="searchValue" class="textField">
				<input type="button" value=" 검색 " class="btn2" onclick="sendIt();"/>			
			</form>		
		</div>

	</div>

	<div id="bbsList_list">
		<div id="title">
			<dl>
				<dt class="cusid">아이디&nbsp;&nbsp;&nbsp;</dt>
				<dt class="cusname">이름&nbsp;&nbsp;&nbsp;</dt>
				<dt class="cusemail">이메일&nbsp;&nbsp;&nbsp;</dt>
				<dt class="custel">전화번호&nbsp;&nbsp;&nbsp;</dt>
				<dt class="cusaddr">주소&nbsp;&nbsp;&nbsp;</dt>
				<dt class="cuspass">pass&nbsp;&nbsp;&nbsp;</dt>
				<dt class="cuscreated">가입일&nbsp;&nbsp;&nbsp;</dt>
			</dl>
		</div>

		<div id="lists">
		<c:forEach var="dto" items="${lists}">
			<dl>
				<dd class="cusid">${dto.cusId }&nbsp;&nbsp;&nbsp;</dd> 
				<dd class="cusname">${dto.cusName }&nbsp;&nbsp;&nbsp;</dd>
				<dd class="cusemail">${dto.cusEmail }&nbsp;&nbsp;&nbsp;</dd>
				<dd class="custel">${dto.cusTel }&nbsp;&nbsp;&nbsp;</dd>
				<dd class="cusaddr">${dto.cusAddr }&nbsp;&nbsp;&nbsp;</dd>
				<dd class="cuspass">${dto.cusPass }&nbsp;&nbsp;&nbsp;</dd>
				<dd class="cuscreated">${dto.cusCreated }&nbsp;&nbsp;&nbsp;</dd>
				<dd><input type="button" value=" 삭제 " class="btn2" 
				onclick="javascript:location.href='<%=cp%>/customerDeleted.action?cusId=${dto.cusId}&pageNum=${pageNum}'"/></dd>
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