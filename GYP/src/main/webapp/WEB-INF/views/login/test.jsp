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
<title>Insert title here</title>
</head>
<body>

<h2>로그인 성공</h2>
<c:if test="${type==1 }">
<a href="<%=cp%>/customerMyPage.action">마이페이지</a>
</c:if>

<c:if test="${type==0 }">
<a href="<%=cp%>/gymMyPage.action">마이페이지</a>
</c:if>

<a href="<%=cp%>/logout.action">로그아웃</a>

</body>
</html>