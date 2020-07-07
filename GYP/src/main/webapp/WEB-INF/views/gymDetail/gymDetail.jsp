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
	<link rel="stylesheet" href="/gyp/resources/css/gymDetail.css">
<title>GYP</title>
</head>
<body>

    <!-- ##### Blog Area Start ##### -->
    <div class="blog-area mt-50 section-padding-100">
        <div class="container">
        
        	<!-- 제목 및 개요 -->
        	<div id="gymDetailSubject">
	            <!-- 체육관 이름 -->
	            <div class="row">
		            <a href="#" class="gymName-title"><span>${gymDto.gymName }</span></a>
		            &nbsp;<span class="gymName-type">&gt;&gt; ${gymDto.gymType }</span>
		            <input type="hidden" id="gymId" value="${gymDto.gymId }"/>
	            </div>
	            <br/>
	            <!-- 체육관 프로그램 -->
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
                               <!--  악 왜 안나와 -->
                                    <!-- Post Title -->
                                    <a href="#" class="post-title">체육관 트레이너</a>
                                    
                                    <!-- Single Teachers -->
					                <div class="row">
						                <c:forEach var="i" begin="0" end="3">
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
                                    <!-- Post Meta -->
                                    <!-- <div class="post-meta">
                                        <p>By <a href="#">Admin</a> | in <a href="#">Health</a> | <a href="#">3 comments</a></p>
                                    </div> -->
                                    <%-- 
                                    <c:forEach var="dto" items="${reviewLists }"  >
                                    	<hr>
                                    	<div class="post-meta">
                                    		${dto.cusId }
                                    		<span>${dto.reCreated }</span>
                                    	</div>
                                    	<!-- 리뷰 내용 -->
                                    	<div>
                                    		${dto.reContent }
                                    	</div>
                                    </c:forEach> --%>
                                    <br>
                                    <br>
                                    
                                    <!-- ajax를 이용한 review List -->
                                    <!-- list -->
                                    <span id="listData" style="display:none"></span>
                                    
                                    <!-- 리뷰 작성 -->
                                    <!-- c:if문 이용해서 체육관 이용해본 사용자에게만 표시 -->
                                    
									<fieldset class="rating">
									    <input type="radio" id="star5" name="rating" value="10" /><label class = "full" for="star5" title="5 stars"></label>
									    <input type="radio" id="star4half" name="rating" value="9" /><label class="half" for="star4half" title="4.5 stars"></label>
									    <input type="radio" id="star4" name="rating" value="8" /><label class = "full" for="star4" title="4 stars"></label>
									    <input type="radio" id="star3half" name="rating" value="7" /><label class="half" for="star3half" title="3.5 stars"></label>
									    <input type="radio" id="star3" name="rating" value="6" /><label class = "full" for="star3" title="3 stars"></label>
									    <input type="radio" id="star2half" name="rating" value="5" /><label class="half" for="star2half" title="2.5 stars"></label>
									    <input type="radio" id="star2" name="rating" value="4" /><label class = "full" for="star2" title="2 stars"></label>
									    <input type="radio" id="star1half" name="rating" value="3" /><label class="half" for="star1half" title="1.5 stars"></label>
									    <input type="radio" id="star1" name="rating" value="2" /><label class = "full" for="star1" title="1 star"></label>
									    <input type="radio" id="starhalf" name="rating" value="1" /><label class="half" for="starhalf" title="0.5 stars"></label>
									</fieldset>
                                    <table width="600" border="0" cellpadding="0" cellspacing="0" align="center">
										<tr>
											<td width="600" colspan="4" height="3" bgcolor="#e6d4a6"></td>
										</tr>
									
										<tr>
											<td width="60" height="30" bgcolor="#eeeeee" align="center">작성자</td>
											
											<td width="240" height="30" style="padding-left: 10px;">
												<!-- session에서 로그인 아이디 가져와서 입력 -->
												<input type="text" id="rname" size="35" maxlength="20" class="boxTF" value=""/>
											</td>
										</tr>
										
										
										<tr>
											<td width="600" colspan="4" height="1" bgcolor="#e6d4a6"></td>
										</tr>
										
										<tr>
											<td width="60" height="30" bgcolor="#eeeeee" align="center">내용</td>
											
											<td width="540" colspan="3" style="padding-left: 10px;">
												<textarea rows="3" cols="84" class="boxTA" style="height:50px;"
												id="rcontent"></textarea>
											</td>
										</tr>
										
										<tr>
											<td width="600" colspan="4" height="3" bgcolor="#e6d4a6"></td>
										</tr>
										
										<tr>
											<td width="600" colspan="4" height="30" align="right"
											style="padding-right: 15px;">
												<input type="button" value="등록하기" class="btn2" id="rsendButton"/>
											</td>
										</tr>
									</table>
                                </div>
                            </div>

                        </div>
                    </div>


                </div>
				<!-- -------------좌측 컬럼 끝-------------- -->
				
				
				<!-- ------------우측 컬럼 시작------------- -->
                <div class="col-12 col-md-4">
                    <div class="fitness-blog-sidebar">

                        <!-- Add Widget -->
                        <!-- <div class="add-widget mb-100">
                            <a href="#"><img src="img/bg-img/add3.png" alt=""></a>
                        </div> -->
                        
                        
                        
                        <div class="single-blog-post mb-100 gymDetailHeadLine">
                          <!--  Post Thumb -->
                           <div class="blog-post-thumb mb-30">
                               <div id="btn1" class="post-date">
                                   <p><span>May</span>10</p>
                               </div>
                               <div id="result"></div>
                           </div>
                        </div>

                        <!-- 제휴시설 미리보기 -->
                        <div class="blog-post-categories mb-100">
                            <h5>제휴시설 미리보기</h5>
                            <!-- 사진 영역 -->
                            <div class=right-col-box>
                            <%-- <c:forEach var="i" begin="0" end="3">
								<img class="gymPic" src="/gyp/resources/img/blog-img/${gymPic[i] }" style="width:100%;max-width:150px">
								
								<!-- The Modal -->
								<div id="myModal" class="modal">
								  <span class="close">&times;</span>
								  <img class="modal-content" id="img01">
								</div>
                            </c:forEach> --%>
                            
                            <div class="row">
							  <div class="column1">
							    <img src="/gyp/resources/img/blog-img/default1.jpg" style="width:100%" onclick="openModal();currentSlide(1)" class="hover-shadow cursor">
							  </div>
							  <div class="column1">
							    <img src="/gyp/resources/img/blog-img/default2.jpg" style="width:100%" onclick="openModal();currentSlide(2)" class="hover-shadow cursor">
							  </div>
							</div>
							<br>  
							<div class="row">
							  <div class="column1">
							    <img src="/gyp/resources/img/blog-img/default3.jpg" style="width:100%" onclick="openModal();currentSlide(3)" class="hover-shadow cursor">
							  </div>
							  <div class="column1">
							    <img src="/gyp/resources/img/blog-img/default4.jpg" style="width:100%" onclick="openModal();currentSlide(4)" class="hover-shadow cursor">
							  </div>
							</div>
							
							<div id="myModal" class="modal">
							  <span class="close cursor" onclick="closeModal()">&times;</span>
							  <div class="modal-content">
							
							    <div class="mySlides">
							      <div class="numbertext">1 / 4</div>
							      <img src="/gyp/resources/img/blog-img/default1.jpg" style="width:100%">
							    </div>
							
							    <div class="mySlides">
							      <div class="numbertext">2 / 4</div>
							      <img src="/gyp/resources/img/blog-img/default2.jpg" style="width:100%">
							    </div>
								
							    <div class="mySlides">
							      <div class="numbertext">3 / 4</div>
							      <img src="/gyp/resources/img/blog-img/default3.jpg" style="width:100%">
							    </div>
							    
							    <div class="mySlides">
							      <div class="numbertext">4 / 4</div>
							      <img src="/gyp/resources/img/blog-img/default4.jpg" style="width:100%">
							    </div>
							    
							    <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
							    <a class="next" onclick="plusSlides(1)">&#10095;</a>
							
							    <div class="caption-container">
							      <p id="caption"></p>
							    </div>
							
							
							    <div class="row">
							    
							    <div class="column2">
							      <img class="demo cursor" src="/gyp/resources/img/blog-img/default1.jpg" style="width:90%" onclick="currentSlide(1)"/>
							    </div>
							    <div class="column2">
							      <img class="demo cursor" src="/gyp/resources/img/blog-img/default2.jpg" style="width:90%" onclick="currentSlide(2)"/>
							    </div>
							    <div class="column2">
							      <img class="demo cursor" src="/gyp/resources/img/blog-img/default3.jpg" style="width:90%" onclick="currentSlide(3)"/>
							    </div>
							    <div class="column2">
							      <img class="demo cursor" src="/gyp/resources/img/blog-img/default4.jpg" style="width:90%" onclick="currentSlide(4)"/>
							    </div>
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
                            	<div class="row">
						                평일 &nbsp;
						                ${gymHour[0] }<br>
						                토요일 &nbsp;
						                ${gymHour[1] }<br>
						                일요일 &nbsp;
						                ${gymHour[2] }<br>
					                </div>
                            </div>
                        </div>
                        
                        
                        <!-- 연락처 및 주소 -->
                        <div class="blog-post-categories mb-100">
                            <div class=right-col-box>
                            	<div class="row">
						                ${gymDto.gymTel }
				                </div>
				                
				                <div class="row">
						                ${gymDto.gymAddr }
				                </div>
                            </div>
                        </div>
                        
<!-- 
                        Latest Blog Posts Area
                        <div class="latest-blog-posts mb-100">
                            <h5>Latest Posts</h5>

                            Single Latest Blog Post
                            <div class="single-latest-blog-post">
                                <div class="post-thumbnail">
                                    <img src="/gyp/resources/img/blog-img/4.png" alt="">
                                </div>
                                <div class="post-content">
                                    Post Title
                                    <a href="#" class="post-title">10 Healthy foods for a good living</a>
                                    Post Meta
                                    <div class="post-meta">
                                        <p>By <a href="#">Admin</a> | in <a href="#">Health</a> | <a href="#">3 comments</a></p>
                                    </div>
                                </div>
                            </div>

                            Single Latest Blog Post
                            <div class="single-latest-blog-post">
                                <div class="post-thumbnail">
                                    <img src="/gyp/resources/img/blog-img/5.png" alt="">
                                </div>
                                <div class="post-content">
                                    Post Title
                                    <a href="#" class="post-title">10 Healthy foods for a good living</a>
                                    Post Meta
                                    <div class="post-meta">
                                        <p>By <a href="#">Admin</a> | in <a href="#">Health</a> | <a href="#">3 comments</a></p>
                                    </div>
                                </div>
                            </div>

                            Single Latest Blog Post
                            <div class="single-latest-blog-post">
                                <div class="post-thumbnail">
                                    <img src="/gyp/resources/img/blog-img/6.png" alt="">
                                </div>
                                <div class="post-content">
                                    Post Title
                                    <a href="#" class="post-title">10 Healthy foods for a good living</a>
                                    Post Meta
                                    <div class="post-meta">
                                        <p>By <a href="#">Admin</a> | in <a href="#">Health</a> | <a href="#">3 comments</a></p>
                                    </div>
                                </div>
                            </div>

                        </div>
 -->
                    </div>
                </div>
            	<!-- -------------우측 컬럼 끝-------------- -->
            </div>
        </div>
    </div>
    <!-- ##### Blog Area End ##### -->


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
    
    <!-- gymDetail.js -->
    <script src="/gyp/resources/js/gymDetail.js"></script>
    

</body>
</html>