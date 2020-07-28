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
	<link rel="stylesheet" href="/gyp/resources/css/createStyle.css">
	<link rel="stylesheet" href="/gyp/resources/css/createCustomer.css">
	 <link rel="stylesheet" href="/gyp/resources/css/customer.css"> 
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
				                  setTimeout(function(){$('#cusId').focus();}, 1);
				                  
				               }
				            }
				         }
				    }) 
			     })
			      
		
			});
		
		
		
	
	$(function() {
		//전화번호 중복체크
		$('#telckbutton').click(function() {

			f = document.myForm;

			$.ajax({
				type : "POST",
				url : "cusTelck",
				data : {
					"cusTel" : $('#cusTel').val()
				},

				success : function(data) { //data : cusidck에서 넘겨준 결과값
					if ($.trim(data) == "YES") {
						if ($('#cusTel').val() != '') {
							alert("사용가능한 전화번호입니다.");
							var ff = $('#cusTel').val();
							$('#checkcusTel').val(ff);
						}
					} else {
						if (f.mode.value != 'updated') {
							if ($('#cusTel').val() != '') {
								alert("중복된 전화번호입니다.");
								$('#cusTel').val('');
								setTimeout(function(){$('#cusTel').focus();}, 1);
							
							}
						}
						if (f.mode.value == 'updated') {
							if ($('#cusTel').val() != '') {

								alert("중복된 전화번호입니다.");

							}
						}

					}
				}
			})
		})

	});

	//주소 찾기 버튼(Daum카카오 주소API 기반)
	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
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
		if (f.mode.value != 'updated')
			var chk = f.check.checked;

		if (!cc1.test(f.cusId.value)) {
			alert('아이디 영문소문자/숫자 4~16자 이내로 입력하세요.');
			f.cusId.focus();
			return false;
		}

		if (f.mode.value != "updated") {
			if ($('#cusId').val() != $('#checkcusId').val()) {
				alert('아이디 중복체크 버튼을 눌러주세요');
				f.checkbutton1.focus();
				return false;
			}
		}

		if (!f.cusName.value) {
			alert("이름을 입력하세요.");
			f.cusName.focus();
			return;
		}

		if (!cc2.test(f.cusPwd.value)) {
			alert('패스워드 영문 대소문자/숫자 4~16자 이내로 입력하세요.');
			f.cusPwd.focus();
			return false;
		}

		if (!f.cusPwd2.value) {
			alert("비밀번호를 한번 더 입력하세요.");
			f.cusPwd2.value.focus();
		}

		if (f.cusPwd.value != f.cusPwd2.value) {
			alert('비밀번호가 일치하지 않습니다.');
			f.cusPwd.value = "";
			f.cusPwd2.value = "";
			f.cusPwd.value.focus();
		}

		if (!cc4.test(f.cusEmail.value)) {
			alert('이메일을 바르게 입력하세요');
			f.cusEmail.focus();
			return false;
		}
		
		//회원가입시 전화번호중복체크
		if (f.mode.value != "updated") {
		if ($('#cusTel').val() != $('#checkcusTel').val()) {
			alert('전화번호 중복체크 버튼을 눌러주세요');
			f.telckbutton.focus();
			return false;
		 }
		}
		
		//개인회원가입시 주소 유효성 
		if (f.mode.value != "updated") {
			if (!f.cusAddrJibun.value) {
				alert("지번주소를 입력하세요.");
				f.cusJibunAddr.focus();
				return;
			}

			if (!f.cusAddrDetail.value) {
				alert("상세주소를 입력하세요.");
				f.cusDetailAddr.focus();
				return;
			}

		}
		//수정시 주소 유효성
		if (f.mode.value == "updated") {
			if (!f.cusAddr.value) {
				alert("주소를 입력하세요.");
				f.cusAddr.focus();
				return;
			}
		}

		if (!cc3.test(f.cusTel.value)) {
			alert('전화번호를 바르게 입력하세요');
			f.cusTel.focus();
			return false;
		}

		if (f.mode.value != 'updated') {
			if (!chk) {
				alert('약관에 동의해주세요');
				return false;
			}
		}

		if (f.mode.value == "updated") {
			alert("회원수정이 성공적으로 완료되었습니다.");
			f.action = "/gyp/customerUpdate_ok.action";

		} else {
			alert("회원가입이 성공적으로 완료되었습니다.");
			f.action = "/gyp/createCustomer_ok.action";

		}

		f.submit();

	}
	
	//개인 회원 탈퇴 (회원정보수정창)
	function sendDelete() {
		
		f = document.myForm;
		 if (confirm("정말 탈퇴하시겠습니까??") == true){    //확인
			 
			 alert("회원탈퇴가 완료되었습니다.")
			f.action ="/gyp/customerDeleted_ok.action";
		    f.submit();

		 }else{   //취소
			 
		     return false;

		 }	
	}
	
</script>
</head>
<body >
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
<%-- <c:if test="${mode!='updated' }">
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
</c:if> --%>
<center>
 	<br/><br/><br/>
	
	<form action="" name="myForm" method="post">
		<table align="center" style="font-size: 15pt; color: #888"
		width="800" cellpadding="0" cellspacing="0" border="0">
	
	<c:if test="${mode!='updated' }">		
		<td colspan="3" class="section-heading">	
				<h6>Fitness Gym</h6>		
				<font style="font-size: 18pt; color: black; ">개인회원 회원가입창</font>
				<hr>
		</td>
			
	</c:if>
	 
	 
	<c:if test="${mode=='updated' }">	
			<td colspan="3" class="section-heading">
				<h6>Fitness Gym</h6>
				<font style="font-size: 20pt; color: black; ">개인회원정보수정창☆</font>
				<hr>
			</td>
	</c:if>
		

			<tr>
				<td class="bokyung_td_left" >아이디</td>
				
				<c:if test="${mode=='updated' }">	
					<td><input type="text"  size="40" maxlength="50"  class="bokyung_member_text" value="${sessionScope.customInfo.sessionId }"
					 disabled/></td>
					<input type="hidden"  name="cusId" id="cusId" value="${sessionScope.customInfo.sessionId }"/>
				</c:if>
					
				<c:if test="${mode!='updated' }">
					<td><input type="text" name="cusId" id="cusId" size="40" maxlength="50" class="bokyung_member_text"
					value="${sessionScope.customInfo.sessionId }"/>
					<input type="button" id = "checkbutton1" name = "checkbutton1" value ="중복체크"/></td>
					<input type="hidden" id = "checkcusId" name = "checkcusId" value =""/>
				</c:if>
			
			</tr>		
		
		<!-- 선 -->
		<tr height="1"><td colspan="2" bgcolor="#cccccc"></td>
		
		
		<tr>
			<td class="bokyung_td_left">이름</td>
				<td>
					<input type="text" name="cusName" size="35" maxlength="20" class="bokyung_member_text"  value="${dto.cusName }"/>
				</td>							
			</td>		
		</tr>
		
		
		<!-- 선 -->
		<tr height="1"><td colspan="2" bgcolor="#cccccc"></td>
		
		<tr>
			<td class="bokyung_td_left">비밀번호</td>
				<td>
					<input type="password" name="cusPwd" size="35" maxlength="50" class="bokyung_member_text" value="${dto.cusPwd }"/>
				</td>							
			</td>		
		</tr>
		
		<!-- 선 -->
		<tr height="1"><td colspan="2" bgcolor="#cccccc"></td>
		
		<tr>
			<td class="bokyung_td_left" style="font-size: 13pt">비밀번호 확인</dt>
				<td>
					<input type="password" name="cusPwd2" size="35" maxlength="50" class="bokyung_member_text" value="${dto.cusPwd }"/>
				</td>							
			</td>		
		</tr>
		
		<!-- 선 -->
		<tr height="1"><td colspan="2" bgcolor="#cccccc"></td>
		
		<tr>
			<td class="bokyung_td_left">이메일</td>
				<td>
					<input type="text" name="cusEmail" size="35" maxlength="50" class="bokyung_member_text" value="${dto.cusEmail }"/>
				</td>							
			</td>		
		</tr>
		
		<!-- 선 -->
		<tr height="1"><td colspan="2" bgcolor="#cccccc"></td>
		
		<tr>
			<td class="bokyung_td_left">전화번호</td>
				<td>
					<input type="text" name="cusTel" id="cusTel" size="35" class="bokyung_member_text" maxlength="50"  value="${dto.cusTel }"/>
					<input type="button" id = "telckbutton" name = "telckbutton" value ="중복체크"/>
					</td>
					<input type="hidden" id = "checkcusTel" name = "checkcusTel" value =""/>
											
			</td>		
		</tr>
		
		<!-- 선 -->
		<tr height="1"><td colspan="2" bgcolor="#cccccc"></td>
		
		<c:if test="${mode!='updated' }">	
		
		<tr>
			<td class="bokyung_td_left">주소</td>
				<td>
					<input type="text" name="cusAddrJibun" style="width : 540px; maxlength="50" 
					class="bokyung_member_text"  id="sample6_address" readonly="readonly"/>
					<input type="button" size="35" maxlength="50"
					 onclick = "sample6_execDaumPostcode();" value="주소 찾기" />		
				</td>							
		</tr>
		</c:if>
		
		
		<c:if test="${mode=='updated' }">	
		<tr>
			<td class="bokyung_td_left">주소</td>
				<td>
					<input type="text" name="cusAddr" style="width : 540px; maxlength="50" 
					class="bokyung_member_text"  id="sample6_address" value="${dto.cusAddr }"/>
					<input type="button" size="35" maxlength="50"
					 onclick = "sample6_execDaumPostcode();" value="주소 찾기" />		
				</td>							
		</tr>
		</c:if>
		 
		 
		 <tr>
			<td class="bokyung_td_left"></td>
			<td>	
				<input type="text" name="cusAddrDetail" value="${dto.cusAddrDetail }" 
				style="width : 540px; maxlength="50" 
				class="bokyung_member_text"  placeholder="상세주소를 입력해주세요" />
			</td>
		</tr>
		 
		</table>
		
		 
 	<c:if test="${mode!='updated' }">
	<table>	
	<tr>
		<td width="100%" height="50%" align="center">
   
		
		<span>약관동의</span>
		</br>
		<textarea 
	     rows="20" cols="110" readonly="readonly" class="jong_textarea">1장 총칙
제1조 (목적)
본 약관은 (주)GYP(이하 “당사”라 함)가 제공하는 TLX PASS 서비스 이용과 관련하여 당사와 회원의 제반 권리, 의무, 책임사항, 관련 절차, 기타 필요한 사항을 규정하는데 그 목적이 있습니다.

제2조 (용어)
본 약관에서 사용하는 주요 용어의 정의는 다음과 같습니다.
1.“서비스”라 함은 구현되는 단말기(PC, TV, 휴대형 단말기 등의 각종 유무선 장치를 포함)와 상관없이 당사와 제휴시설이 “회원”에게 제공하는 TLX PASS 관련 제반 서비스 모두를 의미합니다.
2."회원"이라 함은 당사의 약관 제5조에 정해진 가입 절차에 따라 가입하여 정상적으로 당사의 제휴시설과 GYP 서비스를 이용할 수 있는 권한을 부여 받은 고객을 말합니다.


제2장 회원가입과 멤버십

제3조 (회원가입과 멤버십 구매)
1.회원 가입은 서비스 홈페이지, 어플리케이션을 통해 가능합니다.
회원으로 가입하고자 하는 고객은 당사에서 정한 서비스 홈페이지의 회원 가입 신청서에 정해진 사항을 기입한 후 본 약관과 ‘개인정보처리방침(‘개인정보 수집 제공 및 활용 동의’ 등)'에 동의함으로써 회원가입을 신청합니다.
2.고객으로부터 회원가입 신청이 있는 경우 당사는 자체 기준에 따른 심사를 거친 후 고객에게 회원 자격을 부여 할 수 있으며 회원 자격이 부여된 고객은 당사로부터 가입 완료 공지를 받은 시점부터 회원으로서 지위를 취득하고, 멤버십을 구매/이용할 수 있습니다.
3.회원은 회원자격을 타인에게 양도하거나 대여 또는 담보의 목적으로 이용할 수 없습니다.

제4조 (멤버십 이용 및 관리)
1.회원이 GYP 서비스를 당사와 제휴시설에서 이용하고자 할 경우, 어플리케이션/모바일웹/RFID카드를 이용해야 하며, 당사와 제휴시설은 미성년자 여부나 본인 확인 등 합리적인 이유가 있을 때 회원에게 신분증 제시를 요청할 수 있습니다. 회원은 이러한 요청을 있을 경우 요청에 응해야 정상적이고 원활한 GYP 서비스를 제공 받을 수 있습니다.
2.회원에게 등록된 멤버십은 회원 본인만 사용 가능합니다. 회원 아이디 및 멤버십을 제3자에게 임의적으로 대여 사용하게 하거나 양도 또는 담보의 목적으로 사용 할 수 없으며, 해당 불법 행위로 인해 발생하는 모든 책임은 사용자가 부담합니다.
		</textarea><br>
		<input type="checkbox" name="check"> 약관에 동의합니다.
	
		</td>
	</tr>
	</table>
   	</c:if>
	<table>
	
	<!-- 수정 시, 약관 숨김 -->
	<c:if test="${mode=='updated' }">
   		&nbsp;
   </c:if>

 
	
	<c:if test="${mode!='updated' }">

	<input type="button" value=" 등록하기 " class="btn2" 
	onclick="sendIt();"/>
	<input type="reset" value=" 다시입력 " class="btn2" 
	onclick="document.myForm.cusId.focus();"/>
	<input type="button" value=" 작성취소 " class="btn2" 
	onclick="javascript:location.href='<%=cp%>/login.action';"/>	
	
	</c:if>
	
	<c:if test="${mode=='updated' }">
	
	<input type="button" value=" 수정하기 " class="btn2" 
	onclick="sendIt();"/>
	<input type="button" value=" 작성취소 " class="btn2" 
	onclick="javascript:location.href='<%=cp%>/customerMyPage.action';"/>	
	<input type="button" value=" 회원탈퇴 " class="btn2" 
	onclick="sendDelete();"/>
	</c:if>
	
	<!-- 숨겨놓은 모드 -->	
	<input type="hidden" name="mode" value="${mode }"/> 
		</table>
	</form>
</center>	
 
	
	
	
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