/*------------ 체육관 사진 모달 ------------*/

function openModal() {
  document.getElementById("myModal").style.display = "block";
}

function closeModal() {
  document.getElementById("myModal").style.display = "none";
}

var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > slides.length) {slideIndex = 1}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
}


/*------------ 리뷰 리스트 (ajax) ------------*/

$(function(){
	
	listPage(1);//처음실행시 무조건 1페이지가 나오게함
	
});

//페이지 넘길 준비 
$(document).ready(function(){
	
	//리뷰 작성하기
	$("#rsendButton").click(function(){

		var star;
		$("input[name='rating']:checked").each(function(){
			star = $(this).val();
		});
		
		/*console.log("star: "+ star);*/
		
		var params = "cusId=" + $("#rname").val().replace(" ","")
				+ "&gymId=" + $("#gymId").val()
				+ "&star=" + star
				+ "&reContent=" + $("#rcontent").val();
		
		/*console.log(params);*/
		
		$.ajax({
			
			type:"POST",
			url:"/gyp/reviewCreated.action",
			data:params,
			success:function(args){
				
				//args로 데이터 받음.
				$("#listData").html(args);	//넘어온 데이터를 넣어준다.
				
				//초기화 작업
				$("#rname").val("");
				$("#rcontent").val("");
				
			},
			beforeSend:showRequest,
			error:function(e){
				alert(e.responseText);
			}
			
		});
	});
});


function listPage(page){
	
	var url = "/gyp/reviewList.action?gymId=" + $("#gymId").val()
	$.post(url,{pageNum:page},function(args){
		$("#listData").html(args);
	});
	
	$("#listData").show();
	
}

/*
 * 리뷰삭제 미구현
 * function deleteData(num,page){
	
	var url = "/gyp/deleteReview.action";
	
	$.post(url,{num:num,pageNum:page},function(args){
		$("#listData").html(args);
	});
	
	
}*/


/*------------ 리뷰 작성시 유효성 검사 ------------*/
function showRequest(){
/*	
 * 
	var star;
	$("input[name='rating']:checked").each(function(){
		star = $(this).val();
	});
	
	if(!star){
		alert("평점을 입력하세요");
		return false;
	}
		
	var content = $.trim($("#content").val());
	
	if(!content){
		//content값이 없으면
		alert("\내용을 입력하세요");
		$("#content").focus();
		return false;
	}
	
	if(content.length > 200){
		alert("\n내용은 200자까지만 가능합니다.");
		$("#content").focus();
		return false;
	}
	*/
	return true;
	
}