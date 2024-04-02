<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 유저 장바구니(푸드) 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodCss.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodUserCartList.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | <a href="/food/fcart/foodUserCartList.do">장바구니</a></h2>
	</div>
	<hr noshade="noshade">
	<!-- 내용물 시작 -->
	<div class="cart-container">
		<div class="cart-List">
			<!-- 조건문 -->
			<c:if test="${not empty list}">
			<table id="cart_tb">
				<tr>
					<th><input type="checkbox" id="all_chk" checked="checked"><!-- 전체체크박스 --></th>
					<th>이미지</th>
					<th>상품정보</th>
					<th>수량</th>
					<th>가격</th>
					<th>합계</th>
					<th>선택</th>
				</tr>
				<c:forEach var="cart" items="${list}">
				<tr>
					<td>
						<input type="hidden" value="${cart.cart_num}">
						<input type="checkbox" class="food-chk" data-hidden-price="${cart.f_cart_quantity * cart.f_cart_price}" checked="checked">
					</td>
					<td><img src="${pageContext.request.contextPath}/food/imageView.do?food_num=${cart.foodVO.food_num}&food_type=1" class="food-cart-img"></td>
					<td>${cart.foodVO.food_name}</td>
					<td>
						<input type="number" class="food-count" value="${cart.f_cart_quantity}" min="1" max="9999"><br>
						<input type="hidden" value="${cart.foodVO.food_num}">
						<button type="button" class="change-count" value="${cart.cart_num}">변경</button>
					</td>
					<td><fmt:formatNumber value="${cart.f_cart_price}"/>원</td>
					<td><fmt:formatNumber value="${cart.f_cart_quantity * cart.f_cart_price}"/>원</td>
					<td><button class="del-choice" value="${cart.cart_num}">X 삭제</button></td>
				</tr>
				</c:forEach>
				<tr>
					<td colspan="7" class="align-right">
						<span id="total_is">총 구매금액 :</span><span id="total_price">80000</span>원
					</td>
				</tr>
			</table>
			
			</c:if>
			<!-- 조건문 -->
			<c:if test="${empty list}">
			<div id="result_empty">
				<p class="bdr">장바구니가 비어 있습니다.</p>
			</div>
			</c:if>
			<form id="all_frm" action="/food/forder/foodOrderForm.do" method="post">
			<c:if test="${not empty list}">
				<c:forEach var="cart" items="${list}">
					<input type="hidden" name="cart_numbers" value="${cart.cart_num}">
				</c:forEach>
			</c:if>
			</form>
			<form id="sel_frm" action="/food/forder/foodOrderForm.do" method="post">
			</form>
		</div>
		<!-- 하단 버튼들 -->
		<div class="cart-buttons align-center">
			<button id="all_order" class="order">전체상품주문</button>
			<button id="sel_order" class="order">선택상품주문</button>
			<button class="emptyCart float-right">장바구니 비우기</button>
			<button id="go_foodList" class="float-right">쇼핑계속하기</button>
		</div>
	</div>
	<!-- 내용물 끝 -->
</div>
<!-- 유저 장바구니(푸드) 끝-->