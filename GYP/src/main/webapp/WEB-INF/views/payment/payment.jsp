<%@page import="com.exe.dto.CustomInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
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
   <!-- jQuery-2.2.4 js -->
    <script src="/gyp/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- iamport payment js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
    
   <!-- 결제 -->
   <link rel="stylesheet" href="/gyp/resources/css/payment.css">
<title>GYP</title>

</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
   
   <jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
   <jsp:include page="/WEB-INF/views/layout/header_below.jsp" />

       <!-- ##### Contact Area Start ##### -->
    <section class="contact-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="title mb-100">
                        <h3>결제하기</h3>
                    </div>
                </div>
            </div>

            <div class="row">
               <!-- ------------좌측 컬럼 시작------------- -->
                <div class="col-12 col-md-8" id="paymentLeftCol">
                   <div class="row">
                      <div class="contact-content" style="width: 80%;">
                    
                        <!-- 주문 정보 폼 -->
                        <div class="contact-form-area">
                            <form action="/getForm4Pay.action" method="post" name="payForm" id="payForm">
                            
                               <!-- 주문 상품 -->
                               <hr/>
                               <h6>주문상품</h6>
                               <div id="주문 상품">
                                  <div class="form-group">
                                     <!-- 패스 구매시 -->
                                     <c:if test="${not empty passSelected }">
                                          <span class="form-control" id="item">${passSelected }</span>
                                          <input type="hidden" id="itemVal" value="${passSelected }">
                                       </c:if>
                                       
                                       <!-- 운동용품 구매시 -->
                                       <c:if test="${empty passSelected }">
                                          <div id="productList">
                                          <span id="item" style="display: none;">운동용품</span>
                                          <table id="buying_items">
                                    <tr>
                                       <th width="70px">상품ID</th>
                                       <th width="200px">이미지</th> 
                                       <th width="180px">상품명</th>
                                       <th width="100px">상품가격</th>
                                       <th width="50px">갯수</th> 
                                    </tr>
                                    <c:forEach var="dto" items="${listsToBuy }" >
                                                <tr>
                                                   <td>${dto.productId}<input type="hidden" name="productIdArr" value="${dto.productId}"></td>
                                                   <td><img src="${imagePath }/${dto.productImg }" style="width:120px; height:120px;"/></td>                                          
                                                   <td>${dto.productName }</td>
                                                   <td>${dto.productPrice }</td>
                                                   <td>${dto.count }<input type="hidden" name="productCountArr" value="${dto.count }"></td>
                                                </tr>
                                             </c:forEach>
                                          </table>   
                                          </div>
                                       </c:if>
                                       
                                   </div>
                               </div>
                               <br/><hr/>
                               <!-- 주문자 정보 -->
                               <h6>주문자</h6>
                               <div id="주문자">
                                  <div class="form-group">
                                       <input type="text" class="form-control" id="buyer_name" placeholder="이름" disabled="disabled" value="${cusName }" />
                                   </div>
                                   <div class="form-group">
                                       <input type="text" class="form-control" id="buyer_tel" name="buyerTel" placeholder="전화번호" value="${cusTel }">
                                   </div>
                                   <div>
                                      <input type="hidden" id="buyer_addr" value="${cusAddr }">
                                      <input type="hidden" id="buyer_addr_detail" value="${cusAddrDetail }">
                                   </div>
                               </div>
                                 
                               
                                <c:if test="${empty passSelected }">
                                   <!-- 배송지 정보 -->
                                   <br/><hr/>
                                  <h6>배송지</h6>
                                   <!-- c:if문 써서 주문 상품이 운동용품일때만 보이기 -->
                                   <div id="배송지">
                              <input type="radio" name="deliveryInfo" value="originalDeliver" onclick="copyCusInfo();" checked="checked" >
                              주문자 정보와 동일&nbsp;
                              <input type="radio" name="deliveryInfo" value="newDeliver" onclick="resetValue();">새로 입력
                              
                                      <div class="form-group">
                                          <input type="text" class="form-control" id="receiver_name" name="receiverName" placeholder="수령인"/>
                                          <input type="text" class="form-control" id="receiver_tel" name="receiverTel" placeholder="연락처"/>
                                          <input type="text" class="form-control" id="sample6_address" name="receiverAddr" 
                                          onclick = "sample6_execDaumPostcode();" readonly="readonly" placeholder="배송지 주소"/>
                                          <input type="text" class="form-control" id="detail_address" name="receiverDetailAddr" 
                                          placeholder="상세주소"/>
                                      </div> 
                                   </div>
                              </c:if>
                              
                               
                              <!-- 결제 수단 선택 -->
                              <br/><hr/>
                               <h6>결제수단</h6>
                              <div id="결제수단" class="form-group">
                                 <select name="payMethod" id="payMethod" class="form-control" style="height: auto; padding:10px;">
                              <option value="card" selected="selected">신용카드</option>
                              <option value="trans">실시간계좌이체</option>
                              <option value="vbank">가상계좌</option>
                           </select>
                              </div>
                            </form>
                        </div>
                        
                    </div>
                    </div>
                </div>
               <!-- ------------좌측 컬럼 끝------------- -->
               <!-- ------------우측 컬럼 시작------------- -->
                <div class="col-12 col-md-4" id="paymentRightCol">
                   
                        <!-- 결제 -->
                        <div id="결제">
                            <div style="margin:10px 0;">
                              <!-- <span class="pay-left">결제 상품:&nbsp; </span><br/> --> 
                              <h6>결제 상품: </h6>
                              <c:if test="${not empty passSelected }">
                                 <div style="text-align-last: right;" >
                                    <c:set var="string" value="${passSelected }"/>
                              <c:set var="passNum" value="${fn:substringAfter(string, '_')}" />
                              pass 이용권 ${passNum}개
                                 </div>
                              </c:if>
                              
                              <c:if test="${empty passSelected }">
                                 <div style="text-align-last: right;" >
                                    <c:forEach var="dto" items="${listsToBuy }" varStatus="status">
                                          ${dto.productName }<c:if test="${!status.last}">,</c:if>
                                    </c:forEach>
                                 </div>
                              </c:if>
                            </div>
                            <hr/>
                            <!-- 최종 결제 금액 -->
                              <div style="margin:10px 0;">
                                 <h6>최종 결제 금액 : </h6>
                                 <!-- <span class="pay-left">최종 결제 금액 : </span><br/> -->
                                 <span class="pay-right" style="font-size:40px;">&#8361;<fmt:formatNumber value="${finalPayVal }" pattern="#,###" /></span>
                                 <input type="hidden" id="amount" value="${finalPayVal }"/>
                              </div>
                           <!-- 주문하기 -->
                           <input class="btn fitness-btn btn-2 mt-30" type="button" value="주문하기" id="buyit"
                              style="width: 100%; margin:10px 0;" />
                        </div>
                
                </div>
               <!-- ------------우측 컬럼 끝------------- -->
            </div>
        </div>
    </section>
    <!-- ##### Contact Area End ##### -->

   <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

   
    <!-- ##### All Javascript Script ##### -->
    <!-- Popper js -->
    <script src="/gyp/resources/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="/gyp/resources/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="/gyp/resources/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="/gyp/resources/js/active.js"></script>
    <!-- 다음 카카오 주소API -->
   <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!-- payment js -->
    <script type="text/javascript" src="/gyp/resources/js/payment.js"></script>


</body>
</html>