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
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Favicon -->
<link rel="icon" href="/gyp/resources/img/core-img/favicon.ico">
<!-- Core Stylesheet -->
<link rel="stylesheet" href="/gyp/resources/css/style.css">
<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">

<!-- 마이페이지 -->
<link rel="stylesheet" href="/gyp/resources/css/myPage.css">
   
   <script type="text/javascript">
   
      function toUpdate(){
         
            f = document.myForm;
         
            var str = f.cusPwd.value;
            var ck = f.cusPwdck.value;
            
            str = str.trim();
            
            if(!str){
                alert("\n비밀번호를 입력하세요!");
                f.cusPwd.focus();
                return;
             }
            
            if(str!=ck){
               alert("\n비밀번호가 일치하지 않습니다.");
               f.cusPwd.focus();
               return;
            }
             
             f.cusPwd.value = str;
             
             f.action = "<%=cp%>/customerUpdate.action";
             f.submit();
      }
   </script>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />

<div id="myPage_wrapper" style="font-family: 'Noto Sans KR', sans-serif;">
   <div id="content">
   	  <h5 style="color: green;">CUSTOMER MY PAGE</h5>
      <h2>마이 페이지</h2>
      
      <!-- 회원정보 -->
      <div class="container" id="1">
      
         <span class="mp_title" style="font-size: 19px;">회원정보</span>
         <table  border="0" cellpadding="10" cellspacing="10" style="padding: 2em; text-align: center" >
            <tr>
               <th style="font-size: 20px;" >아이디</th>
               <td style="text-align: left;"> ${cusdto.cusId }</td>
            </tr>
            <tr>
               <th style="font-size: 20px;" >이름</th>
               <td style="text-align: left;">${cusdto.cusName }</td>
            </tr>
            <tr>
               <th style="font-size: 20px;" >연락처</th>
               <td style="text-align: left;">${cusdto.cusTel }</td>
            </tr>
            <tr>
               <th style="font-size: 20px;" >주소</th>
               <td style="text-align: left;">${cusdto.cusAddr }&nbsp;${cusdto.cusAddrDetail }</td>
            </tr>
         </table> 
         
         <div class="right_float">
            <form action="" name="myForm">
               <input type="hidden" name="cusPwdck" value=${cusdto.cusPwd }>
               비밀번호 입력: &nbsp;
               <input type="password" name="cusPwd" class="bokyung_mypage_text"/>&nbsp;&nbsp;
               <input type="button" value="회원정보 수정" onclick="javascript:toUpdate()" 
               class="btn fitness-btn btn-white mt-10" style="min-width: 50px;"/>
            </form>
         </div>
      
      </div>
      
      
      <br><br>
      <!-- 이용권 -->
      <div class="container" id="2">
         <span class="mp_title">이용권</span>
         <table class="table01" border="0" cellpadding="10" cellspacing="10">
            <tr>
               
               <td><font color="blue" size="5" >잔여 패스: ${cusdto.cusPass } PASS  (${cusdto.cusPass*5000 }원)</font></td>
            </tr>
            
         </table>
         <div class="check">
            <c:if test="${cusdto.cusPass==0 }">
               잔여 패스가 없습니다.
            </c:if>
         </div>
         
      </div>
      
      
      <br><br>
      <!-- 예약 -->
      <div class="container" id="3">
         <span class="mp_title">예약내역</span>
         <table class="table01" border="0" cellpadding="10" cellspacing="10">
            <tr style="text-align: center">
               <th width="70">번호</th>
               <th>예약타입</th>
               <th width="180">체육관</th>
               <th width="180">트레이너</th>
               <th width="170">등록일</th>
               <th colspan="2" align="left">&nbsp;게시글 관리</th>
            </tr>
            
            <c:forEach var="bookdto" items="${ booklists }">
               <tr class="tr_white" align="center">
                  <td>${bookdto.bookNum }</td>
                  <td>${bookdto.bookType }</td>
                  <td>${bookdto.gymName }</td>
                  <td>${bookdto.gymTrainerPick }</td>
                  <td>${bookdto.bookCreated }</td>
                  <td style="text-align: center;"><a href="" class="bokyung_mypage_link">수정(임시)</a></td>
                  <td style="text-align: left;"><a href="<%=cp %>/bookDelete.action?bookNum=${bookdto.bookNum}" class="bokyung_mypage_link_D">삭제</a></td>
               </tr>
            </c:forEach>
         </table>
         <div class="check">
            <c:if test="${empty booklists }">
               등록된 예약이 없습니다.
            </c:if>
         </div>
      </div>
      
      
      <br><br>
      <!-- 리뷰 -->
      <div class="container" id="4">
         <span class="mp_title">리뷰 목록</span>
         <table class="table01" border="0" cellpadding="10" cellspacing="10">
            <tr align="left" style="text-align: center;">
               <th width="70">리뷰번호</th>
               <th width="180">체육관</th>
               <th width="170">등록일</th>
               <th width="170">평점</th>
               <th>내용</th>
               <th colspan="2" align="left">&nbsp;게시글 관리</th>
            </tr>
            
            <c:forEach var="reviewdto" items="${ reviewlists }">
               <tr class="tr_white" style="text-align: center;">
                  <td>${reviewdto.reNum }</td>
                  <td>${reviewdto.gymName }</td>
                  <td>${reviewdto.reCreated }</td>
                  <td>${reviewdto.star }</td>
                  <td width="350" style="padding-right: 20px">${reviewdto.reContent }</td>
                  <td><a href="" class="bokyung_mypage_link">수정(임시)</a></td>
                  <td style="text-align: left;"><a href="<%=cp %>/reviewDelete.action?reNum=${reviewdto.reNum}" class="bokyung_mypage_link_D">삭제</a></td>
               </tr>
            </c:forEach>
         </table>
         <div class="check">
            <c:if test="${empty reviewlists }">
               등록된 리뷰 게시물이 없습니다.
            </c:if>
         </div>
      </div>
      
      
      <br><br>
      <!-- Q&A -->
      <div class="container5" id="5">
         <span class="mp_title">제휴시설 찜목록</span>
         <table class="table01" border="0" cellpadding="10" cellspacing="10">
            <tr style="text-align: center;">
               <th align="center">체육관</th>
               <th>주소</th>
               <th>전화번호</th>
               <th colspan="2" align="left">&nbsp;게시글 관리</th>
            </tr>
            
            <c:forEach var="jjimdto" items="${ jjimlists }">
               <tr class="tr_white" style="text-align: center;">
                  <td>${jjimdto.gymName}</td>
                  <td>${jjimdto.gymAddr}</td>
                  <td>${jjimdto.gymTel}</td>
                  <td><a href="<%=cp %>/jjimDelete.action?gymId=${jjimdto.gymId}" class="bokyung_mypage_link_D">삭제</a></td>
               </tr>
            </c:forEach>
         </table>
         <div class="check">
            <c:if test="${empty jjimlists }">
               등록된 찜 게시물이 없습니다.
            </c:if>
         </div>
      </div>
   </div>
</div>

<div style="height: 70px;">&nbsp;</div>
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
</body>
</html>