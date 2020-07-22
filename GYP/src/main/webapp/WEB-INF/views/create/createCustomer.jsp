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
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
	
<title>GYP</title>

<!--  버전 문제 때문에 제이쿼리 이버전으로 사용  -->
<!-- <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script> -->

<script src="http://code.jquery.com/jquery.js"></script>

<!-- 다음 카카오 주소API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<script type="text/javascript">

		$(function (){
			//아이디 중복체크
			    $('#checkbutton1').click(function(){
			        $.ajax({
				     type:"POST",
				     url:"cusIdck",
				     data:{
				            "cusId":$('#cusId').val()
				     },
		  
				     success:function(data){	//data : cusidck에서 넘겨준 결과값
				            if($.trim(data)=="YES"){
				               if($('#cusId').val()!=''){ 
				               	alert("사용가능한 아이디입니다.");
				               var ff = $('#cusId').val();
				              	  $('#checkcusId').val(ff); //인풋히든에다가 #cusId를 보관한다. 왜냐하묜 id입력창에다가
				               }
				           	}else{
				               if($('#cusId').val()!=''){
				                  alert("중복된 아이디입니다.");
				                  $('#cusId').val('');
				                  $('#cusId').focus();
				               }
				            }
				         }
				    }) 
			     })
			      
		
			});

		//주소 찾기 버튼(Daum카카오 주소API 기반)
	     function sample6_execDaumPostcode() {
	         new daum.Postcode({
	             oncomplete: function(data) {
	                 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                 // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                 // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                 var addr = ''; // 주소 변수

	                 //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                 if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                     addr = data.roadAddress;
	                 } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.roadAddress;
	                     addr = data.jibunAddress;
	                 }

	                 // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                 document.getElementById("sample6_address").value = addr;
	                 // 커서를 상세주소 필드로 이동한다.
	               //  document.getElementById("sample6_detailAddress").focus();
	             }
	         }).open();
	     }
	

	function sendIt() {
		
	f = document.myForm;
		
		//아이디 제약조건
		var cc1 = /^[a-z0-9]{4,16}$/;
		
		//패스워드 제약조건
		var cc2 = /^[A-Za-z0-9]{4,16}$/;
		
		//전화번호 제약조건
	 	var cc3 = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-[0-9]{3,4}-[0-9]{4}$/;
		
	 	//이메일 제약조건
		var cc4 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		//약관 동의 제약조건
		if(f.mode.value!='updated')
			var chk = f.check.checked;
		
		
	 	
	 	if(!cc1.test(f.cusId.value)) {
			alert('아이디 영문소문자/숫자 4~16자 이내로 입력하세요.');
			f.cusId.focus();
			return false;
	 	}
	 	
	 	if(f.mode.value!="updated"){
		 	if($('#cusId').val()!= $('#checkcusId').val()) {
		 		alert('아이디 중복체크 버튼을 눌러주세요');
		 		f.checkbutton1.focus();
		 		return false;
		 	}
	 	}

	 	if(!f.cusName.value){
			alert("이름을 입력하세요.");
			f.cusName.focus();
			return; 
		}
	 	
	 	if(!cc2.test(f.cusPwd.value)) {
			alert('패스워드 영문 대소문자/숫자 4~16자 이내로 입력하세요.');
			f.cusPwd.focus();
			return false;
	 	}
	 	
	 	if(!f.cusPwd2.value){
	 		alert("비밀번호를 한번 더 입력하세요.");
	 		f.cusPwd2.value.focus();
	 	}
	 	

	 	if(f.cusPwd.value != f.cusPwd2.value){
	 		alert('비밀번호가 일치하지 않습니다.');
	 		f.cusPwd.value="";
	 		f.cusPwd2.value="";
	 		f.cusPwd.value.focus();
	 	}
	 	
	 	if(!cc4.test(f.cusEmail.value)) {
			alert('이메일을 바르게 입력하세요');
			f.cusEmail.focus();
			return false;
	 	}
	 	
	 	if(!f.cusAddr.value){
			alert("주소를 입력하세요.");
			f.cusAddr.focus();
			return; 
		}
	 	
	 	if(!cc3.test(f.cusTel.value)) {
			alert('전화번호를 바르게 입력하세요');
			f.cusTel.focus();
			return false;
	 	}
	 	
	 	if(f.mode.value!='updated'){
		 	if(!chk) {
		            alert('약관에 동의해주세요');
		            return false;
		    }
	 	}
	 	 
	 	 
	 	if(f.mode.value=="updated"){
	 		alert("회원수정이 성공적으로 완료되었습니다.");
			f.action = "/gyp/customerUpdate_ok.action" ;

		}else{
			alert("회원가입이 성공적으로 완료되었습니다.");	
			f.action = "/gyp/createCustomer_ok.action";			

		}	

		f.submit();
	 	
		
	}

</script>

</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
<c:if test="${mode!='updated' }">
<div id="bbs">
	<div id="bbs_title">
	개인회원 회원가입창☆	
	</div>
</div>
</c:if>
	
<c:if test="${mode=='updated' }">	
<div id="bbs">
	<div id="bbs_title">
	회원정보수정창☆	
	</div>
</div>	
</c:if>

	
	<form action="" name="myForm" method="post">
	<table align="center" style="font-size: 13pt; color: #888"
		width="800" cellpadding="0" cellspacing="0" border="0">
	
		<tr valign="center">
			<td colspan="3">
				<font style="font-size: 20pt; color: black; ">&nbsp;회원가입</font>
				<hr></td>
		
	
				<dt>아이디</dt>
				
				<c:if test="${mode=='updated' }">	
					<input type="text"  size="74" maxlength="100" class="boxTF"  value="${sessionScope.customInfo.sessionId }"
					 disabled/>
					<input type="hidden"  name="cusId" id="cusId" value="${sessionScope.customInfo.sessionId }"/>
				</c:if>
					
				<c:if test="${mode!='updated' }">
					<input type="text" name="cusId" id="cusId" size="74" maxlength="100" class="boxTF" 
					value="${sessionScope.customInfo.sessionId }"/>
					<input type="button" id = "checkbutton1" name = "checkbutton1" value ="체크"/>
					<input type="hidden" id = "checkcusId" name = "checkcusId" value =""/>
				</c:if>
			</dl>		
					
		</div>
		
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이름</dt>
				<dd>
					<input type="text" name="cusName" size="35" maxlength="20" class="boxTF"  value="${dto.cusName }"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>비밀번호</dt>
				<dd>
					<input type="password" name="cusPwd" size="35" maxlength="50" class="boxTF" value="${dto.cusPwd }"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>비밀번호 확인</dt>
				<dd>
					<input type="password" name="cusPwd2" size="35" maxlength="50" class="boxTF" value="${dto.cusPwd }"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이메일</dt>
				<dd>
					<input type="text" name="cusEmail" size="35" maxlength="50" class="boxTF" value="${dto.cusEmail }"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>전화번호</dt>
				<dd>
					<input type="text" name="cusTel" size="35" maxlength="50" class="boxTF" value="${dto.cusTel }"/>
				</dd>							
			</dl>		
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>주소(상세주소 추가로 적어주세요^_^)</dt>
				<dd>
					<input type="text" name="cusAddr" size="35" maxlength="50" 
					class="boxTF" value="${dto.cusAddr }" id="sample6_address"/>
					<input type="button" size="35" maxlength="50"
					class="boxTF" onclick = "sample6_execDaumPostcode();" value="주소 찾기"/>
				</dd>							
			</dl>		
		</div>
		
	
	<table>	
	<tr>
		<td width="100%" height="50%" align="center">
   
		<c:if test="${mode!='updated' }">
		<span style="padding-left: 160px">약관동의</span>
		<br>
		<textarea 
	     rows="20" cols="150" readonly="readonly">미안하다 이거 보여주려고 어그로끌었다.. 
	     나루토 사스케 싸움수준 ㄹㅇ실화냐? 진짜 세계관최강자들의 싸움이다.. 
	     그찐따같던 나루토가 맞나? 
	     진짜 나루토는 전설이다..진짜옛날에 맨날나루토봘는데 왕같은존재인 호카게 되서 세계최강 전설적인 영웅이된나루토보면 
	     진짜내가다 
	     감격스럽고 나루토 노래부터 명장면까지 가슴울리는장면들이 뇌리에 스치면서 가슴이 웅장해진다.. 그리고 극장판에 
	     카카시앞에 
	     운석날라오는 거대한 걸 사스케가 갑자기 순식간에 나타나서 부숴버리곤 개간지나게 나루토가 없다면 마을을 지킬 자는 
	     나밖에 없다 
	     라며 바람처럼 사라진장면은 진짜 나루토처음부터 본사람이면 안울수가없더라 진짜 너무 감격스럽고 보루토를 최근에 알았는데 
	     미안하다.. 지금20화보는데 진짜 나루토세대나와서 너무 감격스럽고 모두어엿하게 큰거보니 내가 다 뭔가 알수없는 
	     추억이라해야되나 그런감정이 이상하게 얽혀있다.. 시노는 말이많아진거같다 좋은선생이고..
	     그리고 보루토왜욕하냐 귀여운데 나루토를보는것같다 성격도 닮았어 그리고버루토에 나루토사스케 둘이싸워도 이기는 
	     신같은존재 나온다는게 사실임?? 그리고인터닛에 쳐봣는디 이거 ㄹㅇㄹㅇ 진짜팩트냐?? 
	     저적이 보루토에 나오는 신급괴물임?ㅡ 나루토사스케 합체한거봐라 진짜 ㅆㅂ 이거보고 개충격먹어가지고
	      와 소리 저절로 나오더라 ;;
	      진짜 저건 개오지는데.. 저게 ㄹㅇ이면 진짜 꼭봐야돼 진짜 세계도 파괴시키는거아니야 .. 와 진짜 
	      나루토사스케가 저렇게 되다니 
	      진짜 눈물나려고했다.. 버루토그라서 계속보는중인데 저거 ㄹㅇ이냐..? 하.. ㅆㅂ 사스케 보고싶다..  
	      진짜언제 이렇게 신급 최강들이 되었을까 옛날생각나고 나 중딩때생각나고 뭔가 슬프기도하고 좋기도하고
	       감격도하고 
	      여러가지감정이 복잡하네.. 아무튼 나루토는 진짜 애니중최거명작임..
		</textarea><br>
		<input type="checkbox" name="check"> 약관에 동의합니다.
		</c:if>
		</td>
	</tr>
	</table>
   
	<!-- 수정 시, 약관 숨김 -->
	<c:if test="${mode=='updated' }">
   		&nbsp;
   </c:if>


	</div>	
	
	
	<c:if test="${mode!='updated' }">
	<div id="bbsCreated_footer">
	<input type="button" value=" 등록하기 " class="btn2" 
	onclick="sendIt();"/>
	<input type="reset" value=" 다시입력 " class="btn2" 
	onclick="document.myForm.cusId.focus();"/>
	<input type="button" value=" 작성취소 " class="btn2" 
	onclick="javascript:location.href='<%=cp%>/list.action';"/>	
	</div>
	</c:if>
	
	<c:if test="${mode=='updated' }">
	<div id="bbsCreated_footer">
	<input type="button" value=" 수정하기 " class="btn2" 
	onclick="sendIt();"/>
	<input type="button" value=" 작성취소 " class="btn2" 
	onclick="javascript:location.href='<%=cp%>/customerMyPage.action';"/>	
	</div>
	</c:if>
	
	<!-- 숨겨놓은 모드 -->	
	<input type="hidden" name="mode" value="${mode }"/>
	
	</form>
	
</div>
	
	
	
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