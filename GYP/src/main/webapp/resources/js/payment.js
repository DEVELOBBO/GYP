
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
    	    amount : 100, //$("#amount").val(),
    	    buyer_name : realTimeValIn("#buyer_name"),	
    	    buyer_tel : realTimeValIn("#buyer_tel"),
    	    buyer_addr : realTimeValIn("#buyer_addr"),
    	    buyer_postcode : '123-456',
    	    card_quota : undefined
    	}, function(rsp) {
    	    if ( rsp.success ) {
		    	if($("#item").html().startsWith("pass_")) {
		    		var params = "item=" + $("#item").html() 
	    	    			+ "&payMethod=" + $("#payMethod").val();
		    	} else {
		    		var productIdArr = new Array();
		    		$("input[name=productIdArr]").each(function() {
		    			productIdArr.push($(this).val());
		    		});
		    		
		    		var productCountArr = new Array();
		    		$("input[name=productCountArr]").each(function() {
		    			productCountArr.push($(this).val());
		    		});
		    		
		    		var params = "item=" + $("#item").html() 
	    	    			+ "&amount=" + $("#amount").val()
	    	    			+ "&payMethod=" + $("#payMethod").val()
	    	    			+ "&receiver_name=" + $("#receiver_name").val()
	    	    			+ "&receiver_tel=" + $("#receiver_tel").val()
	    	    			+ "&receiver_addr=" + $("#receiver_addr").val()
	    	    			+ "&productIdArr=" + productIdArr
	    	    			+ "&productCountArr=" + productCountArr;
		    	}
    	    	
	    	     jQuery.ajax({
	    	      url: "/gyp/actualPayment.action",
	    	      type: 'POST',
	    	      dataType: 'json',
	    	      data: {
	    	    	 imp_uid: rsp.imp_uid,
	    	    	//기타 필요한 데이터가 있으면 추가 전달
	                 merchant_uid: rsp.merchant_uid,
	                 params
	    	      },
	    	      error: function(e){
	    	    	  alert(e.responseText);
	    	      }
	    	     })
	    	     
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
    
    
