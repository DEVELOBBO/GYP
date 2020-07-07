<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!-- gymDetail.action에 띄울 체육관 리뷰 리스트 : ajax 사용해 호출 -->

<c:if test="${totalDataCount!=0 }">

	<c:forEach var="dto" items="${reviewLists }"  >
		<hr>
		<div class="post-meta">
			${dto.cusId }
		<span>${dto.reCreated }</span>
		</div>
		<!-- 리뷰 내용 -->
		<div>
			${dto.reContent }
		</div>
	</c:forEach>

	<div>${pageIndexList }</div>
</c:if>