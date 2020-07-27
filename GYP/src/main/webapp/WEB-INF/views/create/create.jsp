<%@page import="com.exe.dto.CustomInfo"%>
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
	<link rel="stylesheet" href="/gyp/resources/css/style.css">
	<link rel="stylesheet" href="/gyp/resources/css/create.css">
	<!-- font -->	
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
	
	
	

<title>GYP</title>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
<center>	
	<table>
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />

	<div style="height: 100px;"></div>
	
	<dt>
	<input type="button" class="fas fa-id-card-alt fa-10x"   style="border: none;font-size:200px;width:250px;height:220px; color: #000042;" value="&#xf47f;" 
	 onclick="javascript:location.href='<%=cp%>/createCustomer.action';"></input>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" class="fas fa-id-card-alt fa-10x"   style="border: none;font-size:200px;width:250px;height:220px; color:#0BC904" value="&#xf47f;" 
	 onclick="javascript:location.href='<%=cp%>/createGym.action';"></input> 
	</dt> 
	
	<dd>
	<input type="button" class="btn fitness2-btn btn-2" style="font-size:20px; width:210px;height:50px;" value="개인 회원가입">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" class="btn fitness-btn btn-2" style="font-size:20px; width:210px;height:50px;"  value="체육관 회원가입">
	</dd>
	

	
	
	
	
	<div style="height: 300px;"></div>
	
	

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	
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
    
    <!-- font awesome -->
	<script src="https://kit.fontawesome.com/4badd96a47.js" crossorigin="anonymous"></script>

	</table>
</center>
</body>

</html>