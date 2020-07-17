
/*------------------ 결제 api 사용 ------------------*/
    $(function(){
        var IMP = window.IMP;
        IMP.init('imp43882577'); // 가맹점 식별코드
        
        $("#buyit").click(function(){
        	validateUserInput();	// 사용자 입력 검사
        	requestPay();	// 결제
        });
        
        copyCusInfo();
    });
    
    //start up function requestPay
    function requestPay(){
    	var msg;
    	IMP.request_pay({
    	    pg : 'html5_inicis',
    	    pay_method : $("#payMethod").val(),
    	    merchant_uid : 'gypPayment_' + new Date().getTime(),
    	    name : $("#item").html(), //상품명
    	    amount : $("#amount").val(),
    	    buyer_name : realTimeValIn("#buyer_name"),	
    	    buyer_tel : realTimeValIn("#buyer_tel"),
    	    buyer_addr : '서울특별시 강남구 삼성동',
    	    buyer_postcode : '123-456',
    	    card_quota : undefined
    	}, function(rsp) {
    	    if ( rsp.success ) {
    	    	var params = "item=" + $("#item").html() 
    	    			+ "&amount=" + $("#amount").val()
    	    			+ "&payMethod=" + $("#payMethod").val();

    	     //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
    	     jQuery.ajax({
    	      url: "/gyp/actualPayment.action", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
    	      type: 'POST',
    	      dataType: 'json',
    	      data: {
    	    	 imp_uid: rsp.imp_uid,
    	    	//기타 필요한 데이터가 있으면 추가 전달
                 merchant_uid: rsp.merchant_uid,
                 params
    	      },
    	      beforeSend: function(){
    	    	  alert("보낸다?"+params);
    	      },
    	      error: function(e){
    	    	  alert(e.responseText);
    	      }
    	     }).done(function(data) {
	    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	    		if ( everythings_fine ) {
	    			var msg = '결제가 완료되었습니다.';
	    			msg += '\n고유ID : ' + rsp.imp_uid;
	    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	    			msg += '\n결제 금액 : ' + rsp.paid_amount;
	    			msg += '카드 승인번호 : ' + rsp.apply_num;
	    			
	    			alert(msg);
	    		} else {
	    			//[3] 아직 제대로 결제가 되지 않았습니다.
	    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
	    		}
	    	});
    	     	
  	        	window.location.replace("/gyp/payment_ok.action");
  	        
    	    } else {
    	        var msg = '결제에 실패하였습니다.';
    	        msg += '에러내용 : ' + rsp.error_msg;

    	        alert(msg);
    	    }
    	    
    	});
    	 
   	}//end of function requestPay
    
    
    /*--------- input값이 변할때마다 값 세팅하는 함수 ---------*/
    function realTimeValIn(inputId) {
    	var result = $(inputId).val();
    	$(inputId).on("propertychange change keyup paste input", function() {
            var realTimeVal = $(this).val();
            if(realTimeVal == result) {
                return;
            }
            result = realTimeVal;
        });
    	return result;
    }

    /*--------- 사용자가 입력한 값을 검사하는 함수 ---------*/
    function validateUserInput() {
    	
    }
    
    /*--------- 배송지 입력 라디오버튼 기능 ---------*/
    function copyCusInfo() {
    	$("#receiver_name").val($("#buyer_name").val());
    	$("#receiver_tel").val($("#buyer_tel").val());
    	$("#receiver_addr").val($("#buyer_addr").val());
    }
    
    function resetValue() {
    	$("#receiver_name").val("");
    	$("#receiver_tel").val("");
    	$("#receiver_addr").val("");
    }
    
    
