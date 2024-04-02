<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 유저 (푸드)주문상세정보확인 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodCss.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | <a href="${pageContext.request.contextPath}/food/forder/myFoodOrderList.do'">내 주문목록</a> | 주문상세정보</h2>
	</div>
	<hr noshade="noshade">
	<!-- 내용물 시작 -->
	<div class="orderDetail-container">
		<!-- 구매자정보 시작 -->
		<div class="order-title">
			<h2>구매자 정보</h2>
			<hr>
		</div>
		<ul>
			<li>
				<label>주문번호</label>
				<p>${f_order.f_order_num}</p>
			</li>
			<li>
				<label>구매자명</label>
				<p>${f_order.buyer_name}</p>
			</li>
			<li>
				<label>전화번호</label>
				<p>${f_order.buyer_phone}</p>
			</li>
			<li>
				<label>이메일</label>
				<p>${f_order.buyer_email}</p>
			</li>
		</ul>
		<!-- 구매자 정보 끝 -->
		<div class="order-List">
			<div class="order-title">
				<h2>주문 상세 정보</h2>
			</div>
			<table id="order_tb">
				<tr>
					<th>이미지</th>
					<th>상품정보</th>
					<th>수량</th>
					<th>가격</th>
					<th>합계</th>
				</tr>
				<c:forEach var="f_order_detail" items="${list}">
				<tr>
					<td>
						<img src="${pageContext.request.contextPath}/food/imageView.do?food_num=${f_order_detail.food_num}&food_type=1" class="food-cart-img">
					</td>
					<td>${f_order_detail.food_name}</td>
					<td>${f_order_detail.order_quantity}개</td>
					<td><fmt:formatNumber value="${f_order_detail.food_price}"/>원</td>
					<td><fmt:formatNumber value="${f_order_detail.food_total}"/>원</td>
				</tr>
				</c:forEach>
				<tr>
					<td colspan="4" class="align-right"><b>총 구매금액</b></td>
					<td class="align-center">
						<fmt:formatNumber value="${f_order.total_price}"/>원
					</td>
				</tr>
			</table>
			<div class="order-title">
				<h2>결제 정보</h2>
				<hr>
			</div>
			<ul>
				<li>
					<label>결제수단</label>
					<p>${f_order.pg}</p>
				</li>
				<li>
					<label>총 결제금액</label>
					<p><fmt:formatNumber value="${f_order.total_price}"/>원</p>
				</li>
			</ul>
		</div>
		<!-- 하단 버튼들 -->
		<div class="order-buttons align-center">
			<c:if test="${f_order.f_order_status==1}">
				<input type="button" value="QR코드생성" class="orderDetail-btn createQR" onclick="location.href='${pageContext.request.contextPath}/food/forder/myFoodQRcode.do?f_order_num=${f_order.f_order_num}'">
			</c:if>
			<input type="button" value="뒤로가기" class="orderDetail-btn" onclick="location.href='${pageContext.request.contextPath}/food/forder/myFoodOrderList.do'">
		</div>
	</div>
	<!-- 내용물 끝 -->
</div>
<!-- 유저 (푸드)주문상세정보확인 끝 -->