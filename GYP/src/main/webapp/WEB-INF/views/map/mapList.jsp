<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<c:if test="${dataCount!=0 }">
	<div id="mapList" style="width: 470px;">
	<c:forEach var="dto" items="${lists}">
		<hr style="width: 470px;">
		<div class="mapDetail">
		<dl>
			<dd class="">
				<a href="javascript:void(0);"
				onclick='mapSetCenter("${dto.gymAddr }");'> ${dto.gymName } </a>
			</dd>
			<dd class="">${dto.gymTel }</dd>
			<dd class="">${dto.gymHour }</dd>
			<dd class="">${dto.gymAddr }
			<a href="<%=cp%>/gymJjim.action?gymId=${dto.gymId}" target="_blank">
			<img alt="찜하기" src="/gyp/resources/img/core-img/mapLikeIcon.JPG" style="width: 30px"></a>
			<a href="<%=cp%>/gymDetail.action?gymId=${dto.gymId}" target="_blank">
			<img alt="예약하기" src="/gyp/resources/img/core-img/mpaCashIcon.JPG" style="width: 30px"></a>
			</dd>
		</dl>
		</div>
	</c:forEach>
	</div>
	<div style="width:300px; margin: 0 auto; text-align: center;">
		${ajaxPageIndexList}
	</div>
</c:if>

<c:if test="${dataCount==0 }">
	${searchValue} 검색 결과가 없어요.
</c:if>


