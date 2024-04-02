<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 식품 상세 페이지 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/food.public.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodDetail.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | <a href="/food/foodList.do">매장</a> | <a href="/food/foodCompDetailMenu.do?comp_num=${comp.comp_num}">${comp.comp_name}</a></h2>
	</div>
	<hr noshade="noshade">
	<!-- 카테고리 시작 -->
	<div class="food-category">
		<ul class="float-left">
			<li><div class="food-cbox" data-comp_cate="1">치 킨</div></li><!--
		--><li><div class="food-cbox" data-comp_cate="2">술/안주</div></li><!--
		--><li><div class="food-cbox" data-comp_cate="3">분 식</div></li><!--
		--><li><div class="food-cbox" data-comp_cate="4">간 식</div></li><!--
		--><li><div class="food-cbox" data-comp_cate="5">패스트푸드</div></li>
		</ul>
		<form id="foodList_sort" action="foodList.do" method="get">
			<input type="hidden" name=comp_cate id="comp_cate" value="${comp.comp_cate}">
		</form>
		<!-- 관리자 접속시 수정 버튼 생성 -->
		<c:if test="${!empty user.mem_auth && user.mem_auth > 2 && food.comp_num == user.companyDetailVO.comp_num || user.mem_auth == 9}">
			<div class="float-right">
				<input type="button" class="adminBtn" value="수정하기" onclick="location.href='${pageContext.request.contextPath}/food/fixFood.do?food_num=${food.food_num}'">
			</div>
		</c:if>
		<c:if test="${!empty user.mem_auth && user.mem_auth == 2 }">
			<div class="float-right">
			</div>
		</c:if>
	</div>
	<div class="clear"></div>
	<!-- 식품 상세정보 시작 -->
	<div class=comp-container>
		<div class="food-detail"><!-- 상세페이지 링크는 스크립트로 해결해야함. -->
			<div class="f-line"></div>
			<div class="f-img"><img src="${pageContext.request.contextPath}/food/imageView.do?food_num=${food.food_num}&food_type=1" class="food-main-img"></div>
			<div class="food-title"><b>${food.food_name}</b></div>
			<div class="food-price align-right" data-price="${food.food_price}"><b><fmt:formatNumber value="${food.food_price}"/>원</b></div>
			<div class="food-quantity align-right">
				<input type="number" id="food_quantity" min="1" max="999" value="1"><b> 개</b> 
			</div>
			<div class="food-total align-right"><b>총 상품 금액</b><br><span id="food_total">원</span></div>
			<div class="food-btn">
				<input type="button" id="food_order_btn" value="주문하기"><br>
				<input type="button" id="food_cart_btn" value="장바구니">
			</div>
		</div>
		<!-- 장바구니용 폼 -->
		<form id="frm_cart" method="post">
			<input type="hidden" name="food_num" value="${food.food_num}">
			<input type="hidden" name="f_cart_quantity" class="fd-quantity">
			<input type="hidden" name="f_cart_price" value="${food.food_price}">
			<input type="hidden" name="comp_num" value="${food.comp_num}" id="comp_number">
		</form>
		<!-- 주문하기용 폼 -->
		<form id="frm_order" method="post" action="/food/forder/foodOrderForm.do">
		</form>
		<!-- 식품 상세시작 -->	
		<div id="food_detailContent">
			<img class="detail-img" src="${pageContext.request.contextPath}/food/imageView.do?food_num=${food.food_num}&food_type=2">
			<hr>
			<div class="food-content">
				${food.food_content}
			</div>
		</div>
		<!-- 메뉴보기 내용 끝-->
	</div>
	<!-- 목록 끝 -->
</div>
<!-- 식품 상세보기 페이지 끝-->