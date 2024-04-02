<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 유저 (푸드)주문완료 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodCss.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | 주문완료</h2>
	</div>
	<hr noshade="noshade">
	<!-- 내용물 시작 -->
	<div class="order-container">
		<div class="order-List">
			<div class="order-title align-center">
				<h1>주문 완료</h1>
			</div>
			<div class="order-result align-center">
				<p>
					고객님의 주문이 정상적으로 완료되었습니다.<br>
					주문상세정보는 "마이페이지-주문내역-푸드" 에서 확인하실수 있으며,<br>
					매장확인용 QR코드는 주문상세정보에서 불러올 수 있습니다.<br>
					상품 수령시, QR코드를 매장직원에게 보여드리면 상품을 수령하실수 있습니다.<br>
					감사합니다.
				</p>
			</div>
		</div>
		<!-- 하단 버튼들 -->
		<div class="order-buttons align-center">
			<input type="button" value="주문내역" class="order-btn" onclick="location.href='${pageContext.request.contextPath}/food/forder/myFoodOrderList.do'">
			<input type="button" value="홈으로" class="order-btn" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
	<!-- 내용물 끝 -->
</div>
<!-- 유저 (푸드)주문완료 끝 -->