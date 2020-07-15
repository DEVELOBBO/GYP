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
<title>체육관 리스트</title>
<link rel="stylesheet" href="/gyp/resources/css/adminGymStyle.css" type="text/css"/>
<link rel="stylesheet" href="/gyp/resources/css/adminGymList.css" type="text/css"/>
<script type="text/javascript">

	function sendIt(){

		var f = document.searchForm;		
		f.action = "<%=cp%>/adminGymList.action";
		f.submit();

	}
	
</script>
</head>
<body>
<div id="bbsList">
	<div id="bbsList_title">
	체육관 리스트
	</div>

	<div id="bbsList_list">
		<div id="title">
			<dl>
				<dt class="gymId">ID</dt>
				<dt class="gymType">타입</dt>
				<dt class="gymName">이름</dt>
				<!-- <dt class="gymPwd">비밀번호</dt> -->
				<dt class="gymEmail">이메일</dt>
				<dt class="gymTel">전화번호</dt>
				<dt class="gymAddr">주소</dt>
				<!-- <dt class="gymLongitude">경도</dt> -->
				<!-- <dt class="gymLatitude">위도</dt> -->
				<dt class="gymTrainer">트레이너</dt>
				<dt class="gymTrainerPic">트레이너 사진</dt>
				<dt class="gymPic">체육관 사진</dt>
				<dt class="gymProgram">프로그램</dt>
				<dt class="gymFacility">시설</dt>
				<dt class="gymHour">운영시간</dt>
				<dt class="gymCreated">가입일</dt>
				<dt class="gymPass">gymPass</dt>
			</dl>
		</div>
		
		
		<div id="falselists">
		<c:forEach var="dto" items="${falselists}" varStatus="status">
			<dl>
				<dt class="gymId">${dto.gymId }</dt>
				<dt class="gymType">${dto.gymType }</dt>
				<dt class="gymName">${dto.gymName }</dt>
				<dt class="gymEmail">${dto.gymEmail }</dt>
				<dt class="gymTel">${dto.gymTel }</dt>
				<dt class="gymAddr">${dto.gymAddr }</dt>
				<dt class="gymTrainer">
				<c:forEach var="gymTrainer" items="${dto.gymTrainerAry}" varStatus="status">
					${gymTrainer}
				</c:forEach>
				</dt>
				<dt class="gymTrainerPic">
				<c:forEach var="gymTrainerPic" items="${dto.gymTrainerPicAry}" varStatus="status">
					<img src="${imgPath}/${gymTrainerPic}" width="50" height="50">${gymTrainerPic}
				</c:forEach>
				</dt>
				<dt class="gymPic">
				<c:forEach var="gymPic" items="${dto.gymPicAry}" varStatus="status">
					<img src="${imgPath}/${gymPic}" width="50" height="50">${gymPic}
				</c:forEach>
				</dt>
				<dt class="gymProgram">${dto.gymProgram }</dt>
				<dt class="gymFacility">
				<c:forEach var="gymFacility" items="${dto.gymFacilityAry}" varStatus="status">
					${gymFacility }
				</c:forEach>
				</dt>
				<dt class="gymHour">${dto.gymHour }</dt>
				<dt class="gymCreated">${dto.gymCreated }</dt>
				<dt class="gymPass">${dto.gymPass }</dt>
				<dt>
				<input type="button" value=" 승인 " class="btn2" onclick="javascript:location.href='<%=cp%>/adminGymUpdated_ok.action?gymId=${dto.gymId}';"/>
				
				<input type="button" value=" 거절 " class="btn2" onclick="javascript:location.href='<%=cp%>/adminGymDeleted.action?gymId=${dto.gymId}';"/>
				</dt>
			</dl>
		</c:forEach>
		</div>


<h5>************************************************************************</h5>

		<div id="bbsList_header">
			<div id="leftHeader">
				<form action="" name="searchForm" method="post">
					<select name="searchKey" class="selectField">
						<option value="gymName">이름</option>
						<option value="gymType">종목</option>
						<option value="gymAddr">지역</option>				
					</select>
					<input type="text" name="searchValue" class="textField">
					<input type="button" value=" 검색 " class="btn2" onclick="sendIt();"/>			
				</form>		
			</div>
		</div>

		<div id="lists">
		<c:forEach var="dto" items="${lists}">
			<dl>
				<dt class="gymId">${dto.gymId }</dt>
				<dt class="gymType">${dto.gymType }</dt>
				<dt class="gymName">${dto.gymName }</dt>
				<dt class="gymEmail">${dto.gymEmail }</dt>
				<dt class="gymTel">${dto.gymTel }</dt>
				<dt class="gymAddr">${dto.gymAddr }</dt>
				<dt class="gymTrainer">
				<c:forEach var="gymTrainer" items="${dto.gymTrainerAry}" varStatus="status">
					${gymTrainer}
				</c:forEach>
				</dt>
				<dt class="gymTrainerPic">
				<c:forEach var="gymTrainerPic" items="${dto.gymTrainerPicAry}" varStatus="status">
					<img src="${imgPath}/${gymTrainerPic}" width="50" height="50">${gymTrainerPic}
				</c:forEach>
				</dt>
				<dt class="gymPic">
				<c:forEach var="gymPic" items="${dto.gymPicAry}" varStatus="status">
					<img src="${imgPath}/${gymPic}" width="50" height="50">${gymPic}
				</c:forEach>
				</dt>
				<dt class="gymProgram">${dto.gymProgram }</dt>
				<dt class="gymFacility">
				<c:forEach var="gymFacility" items="${dto.gymFacilityAry}" varStatus="status">
					${gymFacility }
				</c:forEach>
				</dt>
				<dt class="gymHour">${dto.gymHour }</dt>
				<dt class="gymCreated">${dto.gymCreated }</dt>
				<dt class="gymPass">${dto.gymPass }</dt>
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