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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Favicon -->
<link rel="icon" href="gyp/resources/img/core-img/favicon.ico">
<!-- Core Stylesheet -->
<link rel="stylesheet" href="gyp/resources/css/style.css">
<!-- jQuery-2.2.4 js -->
<script src="/gyp/resources/js/jquery/jquery-2.2.4.min.js"></script>
<title>GYP</title>
</head>
<body>
	<%-- <jsp:include page="/WEB-INF/views/layout/floating.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" /> --%>

	<div>
		<select name="searchKey" id="searchKey" class="selectField" >
			<option value="gymName">이름</option>
			<option value="gymAddr">지역(OO구)</option>
			<option value="gymType">종목</option>
		</select>
		<input type="text" name="searchValue" id="searchValue" class="textField"
			onkeyup="sendKeyword();" onkeydown="enter();">
		<input type="button" value=" 검색 " id="sendButton" class="btn2" onclick="searchPage();"/>
		<div id="suggestDiv" class="suggest">
			<div id="suggestListDiv"></div>
		</div>
		
		<div>
			<span id="listData" style="display: none"></span>
		</div>

		<div>
			<!-- 지도시작 지도시작 지도시작 지도시작 지도시작 지도시작 -->
			<div id="map" style="width: 500px; height: 400px;"></div>
		</div>

	</div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cf7aec95ee469f062ba92f1f9e4a1b4a&libraries=services,clusterer"></script>
	<script type="text/javascript">
		function mapMake(searchGymName,searchGymAddr) {
			var coordXY = document.getElementById("coordXY"); //검색 지도 경도위도 알아내기
			var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var options = { center: new kakao.maps.LatLng(33.450701, 126.570667),// 위도경도
					level: 3 //지도의 레벨(확대, 축소 정도)
			};
			var map = new kakao.maps.Map(container, options);
			//지도 생성 및 객체 리턴 // 지도타입 컨트롤, 줌 컨트롤 생성
			var mapTypeControl = new kakao.maps.MapTypeControl();
			map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
			var zoomControl = new kakao.maps.ZoomControl();
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			// ★ 주소-좌표 변환 객체를 생성
			var geocoder = new kakao.maps.services.Geocoder();
			// ★ 주소로 좌표를 검색 
			geocoder.addressSearch(searchGymAddr, function(result, status) { // 정상적으로 검색이 완료됐으면
			if (status === kakao.maps.services.Status.OK) {
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			yy = result[0].x;
			xx = result[0].y;
			// 결과값으로 받은 위치를 마커로 표시
			var marker = new kakao.maps.Marker({
				map: map,
				position: coords
			});
			
			// 인포윈도우로 장소에 대한 설명을 표시
			var iwContent = '<div style="padding:5px;">' + searchGymName + '<br>' +
			'<a href="https://map.kakao.com/link/map/'+searchGymName+','+xx+','+yy+'" style="color:blue" target="_blank">큰지도보기</a>&nbsp;' +
			'<a href="https://map.kakao.com/link/to/'+searchGymName+','+xx+','+yy+'" style="color:blue" target="_blank">길찾기</a>'
			+'</div>'
			var infowindow = new kakao.maps.InfoWindow({ content : iwContent }); infowindow.open(map, marker);
			// 지도의 중심을 결과값으로 받은 위치로 이동
			map.setCenter(coords);
			// ★ resize 마커 중심
			var markerPosition = marker.getPosition();
			$(window).on('resize', function(){ map.relayout(); map.setCenter(markerPosition); });
			// ★ 검색 경도위도 표시
			} else {
			console.log('에러');
			}
			});
	}
	</script>


	<!-- ##### Footer Area Start ##### -->
	<%-- <jsp:include page="/WEB-INF/views/layout/footer.jsp" /> --%>
	<!-- ##### All Javascript Script ##### -->
	
	<!-- Popper js -->
	<script src="/gyp/resources/js/bootstrap/popper.min.js"></script>
	<!-- Bootstrap js -->
	<script src="/gyp/resources/js/bootstrap/bootstrap.min.js"></script>
	<!-- All Plugins js -->
	<script src="/gyp/resources/js/plugins/plugins.js"></script>
	<!-- Active js -->
	<script src="/gyp/resources/js/active.js"></script>
	
<script src="/gyp/resources/js/httpRequest.js"></script>
<script type="text/javascript">
	function enter() {
		if (window.event.keyCode == 13) {
            searchPage();
            return;
       }
	}

	$(function() {
		listPage(1);
		mapMake("아이티윌","서울 강남구 테헤란로 114 5층 201호");
	});
	
	function listPage(page) {
		
		var url = "<%=cp%>/mapList.action";
		
		$.post(url,{pageNum:page},function(args){
			$("#listData").html(args);
		});
		
		$("#listData").show();
		
	}
	
	function searchPage() {
		var Key = $("#searchKey").val();
		var Value = $("#searchValue").val();
		var url = "<%=cp%>/mapList.action";
		
		$.post(url,{searchKey:Key,searchValue:Value},function(args){
			$("#listData").html(args);
		});
		
		$("#listData").show();
		
	}
</script>
<script type="text/javascript">
	function sendKeyword(){
		
		var searchKey = document.getElementById("searchKey").value;
		var searchValue = document.getElementById("searchValue").value;

		if(searchValue==""){
			hide();//검색창이 비워져있으면 숨김
			return;
		}

		var params = "searchValue="+searchValue+"&searchKey="+searchKey;
		sendRequest("map_ok.action", params, displaySuggest, "POST");
	}
	
	function displaySuggest(){
		if(httpRequest.readyState==4){
			if(httpRequest.status==200){//서버응답 정상처리인 경우
				var resultText = httpRequest.responseText;//resposne로 넘어온 텍스트 할당
				//alert(resultText);

				//5|abc,ajax,abc마트
				var resultArray = resultText.split("|"); //{5, {abc,ajax,abc} } 로 나눔

				var count = parseInt(resultArray[0]);//5

				var keywordList = null;

				if(count>0){
					keywordList = resultArray[1].split(",");
					var html = "";

					for(var i=0;i<keywordList.length;i++){
						html += "<a href=\"javascript:select('" +
						keywordList[i] + "');\">" +
						keywordList[i] + "</a><br/>";
					}
					var suggestListDiv = document.getElementById("suggestListDiv");
					suggestListDiv.innerHTML = html;
					show();	
				}else{
					//count==0
					hide();
				}	
			}else{
				//status!=200
				hide();
			}
		}else{
			//readyState!=4
			hide();
		}
	}//function..end
	
	//사용자가 제시어중에서 클릭한 키워드
	function select(selectKeyword){
		//클릭한 제시어를 inputbox에 넣어줌
		document.getElementById("searchValue").value = selectKeyword;
		hide();//다른 제시어 감춤
	}

	function show(){
		var suggestDiv = document.getElementById("suggestDiv");
		suggestDiv.style.display = "block";
	}

	function hide(){
		var suggestDiv = document.getElementById("suggestDiv");
		suggestDiv.style.display = "none";
	}

	//처음 DOM이 로드되었을때 보이지 않도록
	window.onload = function(){
		hide();
	}
</script>
	
</body>
</html>