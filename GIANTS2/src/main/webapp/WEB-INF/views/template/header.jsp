<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.cart_count{ 
	position : relative;
	right : 200px;
	color : red;
}
</style>

<div id="header">
	<div id="header_bg_top"></div>
	<div id="header_bg_bottom"></div>
	<div id="center_header">
		<div class="top-menu">
			<ul class="float-right margin-zero">
				<!-- 로그아웃상태 -->
				<c:if test="${empty user}">
					<li class="top-menu-login"><a href="${pageContext.request.contextPath}/member/login.do"><img src="${pageContext.request.contextPath}/images/로그인이미지.png">로그인</a></li>
					<li class="top-menu-register">
						<a href="${pageContext.request.contextPath}/member/registerCommon.do"><img src="${pageContext.request.contextPath}/images/캐릭터.png">회원가입</a>
					</li>
				</c:if>
				
				<!-- 로그인상태 -->
				<c:if test="${!empty user}">
					<li class="top-menu-loginout"><a href="${pageContext.request.contextPath}/member/logout.do"><img src="${pageContext.request.contextPath}/images/로그아웃이미지.png">로그아웃</a></li>
				</c:if>
				<c:if test="${!empty user && user.mem_auth == 2}">
					<li class="top-menu-mypage"><a href="${pageContext.request.contextPath}/member/myPage.do"><img src="${pageContext.request.contextPath}/images/캐릭터.png">마이페이지</a></li>
					<li class="top-menu-food-cart"><a href="${pageContext.request.contextPath}/food/fcart/foodUserCartList.do">장바구니(푸드)</a></li>
					
					<li class="top-menu-cart"><a href="${pageContext.request.contextPath}/gorder/goods_cart.do">장바구니</a></li>
					<c:if test="${cart_count > 0 }">
					 	<span class="cart_count">${cart_count}</span>
					</c:if>
					<li class="top-menu-chat"><a href="${pageContext.request.contextPath}/chat/chatList.do"><img id="chatlist" src="${pageContext.request.contextPath}/images/speech-bubble.png"></a></li> 
				</c:if>
				<c:if test="${!empty user && user.mem_auth == 3}">
					<li class="top-menu-mypage"><a href="${pageContext.request.contextPath}/member/myPage.do"><img src="${pageContext.request.contextPath}/images/캐릭터.png">기업페이지</a></li>
				</c:if>
				
				<!-- 로그인 상태 (관리자)-->
				<c:if test="${!empty user && user.mem_auth == 9}">	
					<li class="top-menu-loginout"><a href="${pageContext.request.contextPath}/member/logout.do"><img src="${pageContext.request.contextPath}/images/로그아웃이미지.png">로그아웃</a></li>
					<li class="top-menu-mypage"><a href="${pageContext.request.contextPath}/member/myPage.do"><img src="${pageContext.request.contextPath}/images/캐릭터.png">관리페이지</a></li>
				</c:if>
				
			</ul>
		</div>
		<div class="nav">
			<h1><a href="${pageContext.request.contextPath}/main/main.do"><img src="${pageContext.request.contextPath}/images/Giantlogo.png"></a></h1>
			<div class="inner-nav">
				<ul> 
				    <li class="li_depth1"><a href="${pageContext.request.contextPath}/introduce/stadium.do" class="dep1_tit"><span>소개</span></a>
				   <li class="li_depth1"><a href="${pageContext.request.contextPath}/news/newsList.do" class="dep1_tit"><span>NEWS</span></a>
				   <li class="li_depth1"><a href="${pageContext.request.contextPath}/goods/goodsList.do" class="dep1_tit"><span>굿즈</span></a>
				   <li class="li_depth1"><a href="${pageContext.request.contextPath}/ticket/ticket.do" class="dep1_tit"><span>티켓</span></a>
				   <li class="li_depth1"><a href="${pageContext.request.contextPath}/food/foodList.do" class="dep1_tit"><span>푸드</span></a>
				   <li class="li_depth1"><a href="${pageContext.request.contextPath}/trading/tradingList.do" class="dep1_tit"><span>중고거래</span></a> 
				   <li class="li_depth1"><a href="${pageContext.request.contextPath}/commu/commuList.do" class="dep1_tit"><span>커뮤니티</span></a> 
				</ul>
			</div>
		</div>
	</div>
</div>






