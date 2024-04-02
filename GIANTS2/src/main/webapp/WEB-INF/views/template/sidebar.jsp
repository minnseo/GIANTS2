<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sidebar.js"></script>
<!-- 사이드바 시작 -->
<!-- button -->
<div class="nav-right visible-xs">
	<div class="button" id="btn">
		<div class="bar top"></div>
		<div class="bar middle"></div>
		<div class="bar bottom"></div>
	</div>
</div>
<!-- nav-right -->
<nav>
	<div class="nav-right hidden-xs">
		<div class="button" id="btn">
			<div class="bar top"></div>
			<div class="bar middle"></div>
			<div class="bar bottom"></div>
		</div>
	</div>
   <!-- nav-right -->
</nav>
<div class="sideTop"></div>
<div class="sidebar-hr hr-out"></div>
<div class="sidebar sidebar-Fout">
	<div class="sidebar-left">
		<ul class="sidebar-list">
			<li id="item1" class="sidebar-item"><a href="#">소개</a></li>
			<li id="item2"class="sidebar-item"><a href="#" >NEWS</a></li>
			<li id="item3"class="sidebar-item"><a href="#">굿즈</a></li>
			<li id="item4"class="sidebar-item"><a href="#">티켓</a></li>
			<li id="item5"class="sidebar-item"><a href="#">푸드</a></li>
			<li id="item6"class="sidebar-item"><a href="#">중고거래</a></li>
			<li id="item7"class="sidebar-item"><a href="#">커뮤니티</a></li>
		</ul>
	</div>
	<div id="sub_item1" class="sidebar-right hide">
		<ul class="sidebar-list">
			<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/introduce/stadium.do">구장 소개</a></li>
			<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/introduce/map.do">오시는길</a></li>
			<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/introduce/map.do">먹거리</a></li>
			<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/introduce/player.do">소개</a></li>
		</ul>
	</div>
	<div id="sub_item2" class="sidebar-right hide">
		<ul class="sidebar-list">
			<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/news/newsList.do">자이언츠 뉴스</a></li>
		</ul>
	</div>
	<div id="sub_item3" class="sidebar-right hide">
		<ul class="sidebar-list">
			<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/goods/goodsList.do">상품목록</a></li>
			<c:if test="${!empty user && user.mem_auth == 2}">
				<li class="sidebar-item-sub"><a href="#">장바구니(굿즈)</a></li>
				<li class="sidebar-item-sub"><a href="#">주문목록(굿즈)</a></li>
			</c:if>
		</ul>
	</div>
	<div id="sub_item4" class="sidebar-right hide">
		<ul class="sidebar-list">
			<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/ticket/gameList.do">티켓</a></li>
		</ul>
	</div>
	<div id="sub_item5" class="sidebar-right hide">
		<ul class="sidebar-list">
			<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/food/foodList.do">매장목록</a></li>
			<c:if test="${!empty user && user.mem_auth == 2}">
				<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/food/fcart/foodUserCartList.do">장바구니(푸드)</a></li>
				<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/food/forder/myFoodOrderList.do">내 주문목록(푸드)</a></li>
			</c:if>
		</ul>
	</div>
	<div id="sub_item6" class="sidebar-right hide">
		<ul class="sidebar-list">
			<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/trading/tradingList.do">중고거래</a></li>
		</ul>
	</div>
	<div id="sub_item7" class="sidebar-right hide">
		<ul class="sidebar-list">
			<li class="sidebar-item-sub"><a href="${pageContext.request.contextPath}/commu/commuList.do">커뮤니티</a></li>
		</ul>
	</div>
</div>





