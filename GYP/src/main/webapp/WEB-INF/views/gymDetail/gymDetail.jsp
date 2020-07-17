<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- BootStrap DatePicker CSS -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.css" rel="stylesheet" type="text/css" />
	<!-- Favicon -->
	<link rel="icon" href="/gyp/resources/img/core-img/favicon.ico">
	<!-- Core Stylesheet -->
	<link rel="stylesheet" href="/gyp/resources/css/style.css">
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
	
	<!-- 짐 디테일 -->
	<link rel="stylesheet" href="/gyp/resources/css/gymDetail.css">
	<link rel="stylesheet" href="/gyp/resources/css/heart.css">
	
<title>GYP</title>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
	
	<!-- hidden parameters -->
    <input type="hidden" id="gymId" value="${gymDto.gymId }"/>
    <input type="hidden" id="cusId" value="${info.sessionId }"/>
	<input type="hidden" id="gymName" value="${gymDto.gymName }"/>
	<input type="hidden" id="gymAddr" value="${gymDto.gymAddr }"/>
	
    <!-- ##### Blog Area Start ##### -->
    <div class="blog-area mt-50 section-padding-100">
        <div class="container">
        
        	<!-- 제목 및 개요 -->
        	<div id="gymDetailSubject">
	            <!-- 체육관 이름 + 타입 -->
	            <div class="row">
		            <a href="#" class="gymName-title"><span>${gymDto.gymName }</span></a>
		            &nbsp;<span class="gymName-type">&gt;&gt; ${gymDto.gymType }</span>
	            </div>
	            <br/>
	            <!-- 체육관 프로그램 내용 -->
	            <div class="col-12">
		            <div class="single-blog-post gymDetailHeadLine">
		              	<div id="gymDetailGymProgram">
			            	${gymDto.gymProgram } 
		                </div>
	                </div>
	            </div>
	            <div class="col-12 col-md-4">&nbsp;</div>
            </div>
            
            <div class="row">
            	<!-- ------------좌측 컬럼 시작------------- -->
                <div class="col-12 col-md-8" id="gymDetailLeftCol">
                    <div class="fitness-blog-posts">
                        <div class="row">

                            <!-- 체육관 트레이너 -->
                            <div class="col-12">
                                <div class="single-blog-post mb-100 gymDetailHeadLine">
                                    <!-- Post Title -->
                                    <a href="#" class="post-title">체육관 트레이너</a>
                                    
                                    <!-- 체육관 트레이너 목록 -->
					                <div class="row">
						                <c:forEach var="i" begin="0" end="${gymTrainerPic.size()-1 }">
							                <div class="col-3">
									           <div class="single-teachers-area mb-100">
							                        <!-- Bg Gradients -->
							                        <div class="teachers-bg-gradients"></div>
							                        <!-- Thumbnail -->
							                        <div class="teachers-thumbnail">
							                            <img src="/gyp/resources/img/team-img/${gymTrainerPic[i]}" alt="${gymTrainer[i]}">
							                        </div>
							                        <!-- Meta Info -->
							                        <div class="teachers-info">
							                            <h6>${gymTrainer[i]}</h6>
							                            <span>Personal trainer</span>
							                        </div>
						                    	</div>
							                </div>
						                </c:forEach>
					                </div>
                                </div>
                            </div>

                            <!-- 체육관 리뷰 -->
                            <div class="col-12">
                                <div class="single-blog-post mb-100 gymDetailHeadLine">
                                    <!-- Post Title -->
                                    <a href="#" class="post-title">체육관 리뷰</a>
                                    <br>
                                    
                                    <!-- ajax를 이용한 리뷰 리스트 및 리뷰 작성 : reviewList.jsp 참조 -->
                                    <span id="listData" style="display:none"></span>
									
                                </div>
                            </div>
                            
                        <!-- 관련 상품 뿌리기 -->
	                    <div class="col-12">
		                    <h4>${gymDto.gymType }관련 인기 상품<span>&nbsp;
		                    <a href="/gyp/productList.action">더보기</a></span></h4>
                    <!-- 상품리스트로 더보기 (링크 수정 필요) -->
	                    </div>
		                    <br/><br/>
		                    
		                    <c:forEach var="productDto" items="${productLists }">
				                <div class="single-price-table mb-100">
			                        <img src="/gyp/resources/img/product/${productDto.productImg}" alt="${productDto.productName }">
			                        <div class="price-table-content">
			                            <!-- price -->
			                            <h4 class="price"><span>${productDto.productId }</span></h4>
			                            <h6>${productDto.productName }</h6>
			                            <!-- Price Data -->
			                            <ul class="price-data">
			                                <li><i class="fa fa-circle" aria-hidden="true"></i> &#8361;${productDto.productPrice }</li>
			                                <li><i class="fa fa-circle" aria-hidden="true"></i>${productDto.productContent }</li>
			                            </ul>
			                            <!-- btn -->
			                            <a href="/gyp/productDetail.action?productId=${productDto.productId }" class="btn fitness-btn mt-30">자세히 보기</a>
			                        </div>
			                    </div>
		                    </c:forEach>
                        </div>
                    </div>


                </div>
				<!-- -------------좌측 컬럼 끝-------------- -->
				
				
				<!-- ------------우측 컬럼 시작------------- -->
                <div class="col-12 col-md-4">
                    <div class="fitness-blog-sidebar">

						<div class="row">
							<!-- 예약 모달 버튼 -->
							<div class="single-blog-post mb-100 gymDetailHeadLine">
								<!--  Post Thumb -->
								<div class="blog-post-thumb mb-30">
									<div id="gymBook" class="post-date1" data-toggle="modal"
										data-target="#bookModal" data-backdrop="static" data-keyboard="false">
										<p>
											<span>${gymDto.gymPass }&nbsp;pass</span>
										</p>
									</div>
								</div>
							</div>

							<!-- 찜 버튼 -->
							<div class="single-blog-post mb-100 gymDetailHeadLine">
								<div class="blog-post-thumb mb-30">
									<div id="gymJjim" class="post-date2">
										<form action="" method="POST" name="JjimForm">
											<div id="main-content">
												  <div>
												  	<input type="hidden" name="gymId" id="gymIdInJjimForm" value="${gymDto.gymId }">
												 	<c:if test="${not empty whetherJjim}">
												 		<input type="hidden" id="whetherJjim" name="whetherJjim" value="${whetherJjim }"/>
												 	</c:if>
												    <input type="checkbox" id="jjimcheckbox" />
												    <label for="jjimcheckbox">
												      <svg id="heart-svg" viewBox="467 389 58 57" xmlns="http://www.w3.org/2000/svg">
												        <g id="Group" fill="none" fill-rule="evenodd" transform="translate(467 392)">
												          <path d="M29.144 20.773c-.063-.13-4.227-8.67-11.44-2.59C7.63 28.795 28.94 43.256 29.143 43.394c.204-.138 21.513-14.6 11.44-25.213-7.214-6.08-11.377 2.46-11.44 2.59z" id="heart" fill="#AAB8C2"/>
												          <circle id="main-circ" fill="#E2264D" opacity="0" cx="29.5" cy="29.5" r="1.5"/>
												
												          <g id="grp7" opacity="0" transform="translate(7 6)">
												            <circle id="oval1" fill="#9CD8C3" cx="2" cy="6" r="2"/>
												            <circle id="oval2" fill="#8CE8C3" cx="5" cy="2" r="2"/>
												          </g>
												
												          <g id="grp6" opacity="0" transform="translate(0 28)">
												            <circle id="oval1" fill="#CC8EF5" cx="2" cy="7" r="2"/>
												            <circle id="oval2" fill="#91D2FA" cx="3" cy="2" r="2"/>
												          </g>
												
												          <g id="grp3" opacity="0" transform="translate(52 28)">
												            <circle id="oval2" fill="#9CD8C3" cx="2" cy="7" r="2"/>
												            <circle id="oval1" fill="#8CE8C3" cx="4" cy="2" r="2"/>
												          </g>
												
												          <g id="grp2" opacity="0" transform="translate(44 6)">
												            <circle id="oval2" fill="#CC8EF5" cx="5" cy="6" r="2"/>
												            <circle id="oval1" fill="#CC8EF5" cx="2" cy="2" r="2"/>
												          </g>
												
												          <g id="grp5" opacity="0" transform="translate(14 50)">
												            <circle id="oval1" fill="#91D2FA" cx="6" cy="5" r="2"/>
												            <circle id="oval2" fill="#91D2FA" cx="2" cy="2" r="2"/>
												          </g>
												
												          <g id="grp4" opacity="0" transform="translate(35 50)">
												            <circle id="oval1" fill="#F48EA7" cx="6" cy="5" r="2"/>
												            <circle id="oval2" fill="#F48EA7" cx="2" cy="2" r="2"/>
												          </g>
												
												          <g id="grp1" opacity="0" transform="translate(24)">
												            <circle id="oval1" fill="#9FC7FA" cx="2.5" cy="3" r="2"/>
												            <circle id="oval2" fill="#9FC7FA" cx="7.5" cy="2" r="2"/>
												          </g>
												        </g>
												      </svg>
												    </label>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
							

						</div>

						<!-- 예약 모달 -->
                        <div id="bookModal" class="modal fade" role="dialog">
						  <div class="modal-dialog modal-lg">
						
						    <!-- Modal content-->
						    <div class="modal-content">
							    <form action="" method="post" name="bookForm">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal">&times;</button>
							        <h4 class="modal-title">
										${gymDto.gymName } 체육관(${gymDto.gymType })을 선택하셨네요!<br/>
										<span>${gymDto.gymPass }</span>pass가 차감됩니다. 
									</h4>
							      </div>
							      <div class="modal-body">
							      	<!-- hidden parameters -->
							      	<input type="hidden" name="gymId" value="${gymDto.gymId }">
							      
									<div class="modal-body-select">
							        	<label for="selectTrainer">트레이너 : </label>
									  <select name="gymTrainerPick" id="selectTrainer">
										    <option value="" disabled="disabled" selected="selected">트레이너를 선택해주세요</option>
										  <c:forEach var="i" begin="0" end="3">
										    <option value="${gymTrainer[i]}">${gymTrainer[i]}</option>
									  	  </c:forEach>
									  </select>
							        </div>
	
									<!-- 예약 날짜 선택 -->
									<div class="modal-body-select">
							        	<label for="datepicker">날짜 : </label>
										<div id="datepicker" class="input-group date">
										    <input class="form-control" type="text" readonly />
										    <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
										    <input type="hidden" id="datePick" name="datePick" value=""/>
										</div>
							        </div>
							        
							        <!-- 시간 선택 -->
							        <div class="modal-body-select">
							        	<label for="time-select-style">시간 : </label>
							        	<div class="time-select-style">
								        		<select id="select-options-wdays" class="select-options" name="bookHourWd">
										    		<option value="" disabled="disabled" selected="selected">시간을 선택해주세요</option>
												  <c:forEach var="i" begin="0" end="${optionTimes0.size()-1 }">
												    <option value="${optionTimes0[i] }">${optionTimes0[i] }</option>
												  </c:forEach>
											 	</select>
											  
											  <select id="select-options-sat" class="select-options" name="bookHourSat">
										    		<option value="" disabled="disabled" selected="selected">시간을 선택해주세요</option>
										  		  <c:forEach var="i" begin="0" end="${optionTimes1.size()-1 }">
												     <option value="${optionTimes1[i] }">${optionTimes1[i] }</option>                                                                                                                                                                                                                                                                                                                                                             ""    <option value="${optionTimes1[i] }">${optionTimes1[i] }</option>
												  </c:forEach>
											  </select>
											    
											  <select id="select-options-sun" class="select-options" name="bookHourSun">
										    		<option value="" disabled="disabled" selected="selected">시간을 선택해주세요</option>
											  	<c:forEach var="i" begin="0" end="${optionTimes2.size()-1 }">
												    <option value="${optionTimes2[i] }">${optionTimes2[i] }</option>
												  </c:forEach>
											  </select>
											  
										</div>
							        </div>
							        
							        <div class="modal-body-select">
							        	<input type="radio" name="bookType" value="online">온라인
										<input type="radio" name="bookType" value="offline">오프라인
							        </div>
							        
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-default" 
							        data-toggle="modal" data-target="#bookConfirmModal" data-backdrop="static" data-keyboard="false">예약하기</button>
							      </div>
						      </form>
						    </div>
						
						  </div>
						</div>
                       <!-- 예약여부 재확인 모달 -->
						<div id="bookConfirmModal" class="modal fade" role="dialog" data-backdrop="false">
						    <div class="modal-dialog">
						        <!-- Modal content-->
						        <div class="modal-content">
						            <div class="modal-body">
						                <p>예약 하시겠습니까? ${gymDto.gymPass }pass가 차감됩니다.<br/>
						                	<span>잔여 pass: ${cusPassLeft }pass</span>
						                </p>
						                <button type="button" class="btn btn-danger" id="confirmclosed" >예약</button>
						                <button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
						            </div>
						        </div>
						    </div>
						</div>

                        <!-- 제휴시설 미리보기 -->
                        <div class="blog-post-categories mb-100">
                            <h5>제휴시설 미리보기</h5>
                            <!-- 사진 영역 -->
                            <div class=right-col-box>
                            
							<c:forEach var="i" begin="1" end="4">
								<div class="column1">
								<img src="/gyp/resources/img/blog-img/${gymPic[i-1] }" style="width:100%" onclick="openModal();currentSlide(${i})" class="hover-shadow cursor">
								</div>
								<c:if test="i%2==0">
									</div><div class="row">
								</c:if>
							</c:forEach>
							
							<!-- 체육관 사진 모달 -->
							<div id="myModal" class="modal" style="z-index: 100000000001">
							  <span class="close cursor" onclick="closeModal()">&times;</span>
							  <div class="modal-content">
								<c:forEach var="i" begin="0" end="3">
								    <div class="mySlides">
								      <div class="numbertext">${i+1 } / 4</div>
								      <img src="/gyp/resources/img/blog-img/${gymPic[i] }" style="width:100%">
								    </div>
							    </c:forEach> 
							    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
							    <a class="next" onclick="plusSlides(1)">&#10095;</a>
							
							    <div class="caption-container">
							      <p id="caption"></p>
							    </div>
							    
								<div class="row">
									<c:forEach var="i" begin="0" end="3">
									    <div class="column2">
									      <img class="demo cursor" src="/gyp/resources/img/blog-img/${gymPic[i] }"  
									      	style="width:90%;" onclick="currentSlide( ${i+1 })"/>
									    </div>
								 	</c:forEach> 
							 	</div> 
							 	
							  </div>
							</div>
                            
                            </div>
                        </div>
                        
                        
                        <!-- 이용가능 시설 -->
                        <div class="blog-post-categories mb-100">
                            <h5>이용가능 시설</h5>
                            <div class=right-col-box>
                            	<div class="row">
						                <c:forEach var="i" begin="0" end="3">
							                <div class="col-3">
						                        <div class="teachers-info">
						                        	<div class="facility-rect">
							                        	<c:if test="${gymFacility[i] == '주차'}">
							                        		<img alt="주차" src="/gyp/resources/img/gymFacility/parking.png">
							                        	</c:if>
							                        	<c:if test="${gymFacility[i] == '샤워장'}">
							                        		<img alt="주차" src="/gyp/resources/img/gymFacility/shower.png">
							                        	</c:if>
							                        	<c:if test="${gymFacility[i] == '타올'}">
							                        		<img alt="주차" src="/gyp/resources/img/gymFacility/towel.png">
							                        	</c:if>
							                        	<c:if test="${gymFacility[i] == '운동복'}">
							                        		<img alt="주차" src="/gyp/resources/img/gymFacility/tshirt.png">
							                        	</c:if>
						                        	</div>
						                            <h6>${gymFacility[i]}</h6>
						                        </div>
							                </div>
						                </c:forEach>
					                </div>
                            </div>
                        </div>
                        
                        
                        <!-- 이용 시간 -->
                        <div class="blog-post-categories mb-100">
                            <h5>이용 시간</h5>
                            <div class=right-col-box>
				                <font color="gray">평일</font> &nbsp;${gymHour[0] }
				                <br/><br/>
				                <font color="blue">토요일</font> &nbsp;${gymHour[1] }
				                <br/><br/>
				                <font color="red">일요일</font> &nbsp;${gymHour[2] }
				                <br/><br/>
                            </div>
                        </div>
                        
                        
                        <!-- 연락처 및 주소 -->
                        <div class="blog-post-categories mb-100">
                 	       <h5>연락처 및 주소</h5>
                            <div class=right-col-box>
                            	<div class="row">
						                ${gymDto.gymTel }
				                </div>
				                
				                <div class="row">
						                ${gymDto.gymAddr }
				                </div>
				                
				                <div id="map" style="width:400px;height:300px;"></div>
                            </div>
                        </div>
                        


                    </div>
                </div>
            	<!-- -------------우측 컬럼 끝-------------- -->
            </div>
        </div>
    </div>
    <!-- ##### Blog Area End ##### -->

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
    <!-- Bootstrap DatePicker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.js"></script>
    <!-- Moment js -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
	<!-- 카카오 지도 api -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d087512990dd20366e00ecdffb1ea8cd&libraries=services,clusterer,drawing"></script>
    <!-- 짐디테일 -->
    <script src="/gyp/resources/js/gymDetail.js"></script>
    
</body>
</html>