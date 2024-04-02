<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- 유저 주문하기(푸드) 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodCss.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodOrderForm.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | 주문하기</h2>
	</div>
	<hr noshade="noshade">
	<!-- 내용물 시작 -->
	<div class="order-container">
		<form:form modelAttribute="f_orderVO" action="foodOrder.do" id="order_form">
		<div class="order-List">
			<input type="hidden" id="total_price" name="total_price" value="${total_price}">
			<input type="hidden" id="comp_name" value="${comp_name}">
			<div class="order-title">
				<h2>주문 상품 목록</h2>
			</div>
			<table id="order_tb">
				<tr>
					<th>이미지</th>
					<th>상품정보</th>
					<th>수량</th>
					<th>가격</th>
					<th>합계</th>
				</tr>
				<c:forEach var="f_cart" items="${list}">
				<input type="hidden" name="cart_numbers" value="${f_cart.cart_num}">
				<input type="hidden" id="comp_num" name="comp_num" value="${f_cart.foodVO.comp_num}">
				<input type="hidden" class="food-name" value="${f_cart.foodVO.food_name}">
				<tr>
					<td>
						<img src="${pageContext.request.contextPath}/food/imageView.do?food_num=${f_cart.food_num}&food_type=1" class="food-cart-img">
					</td>
					<td>${f_cart.foodVO.food_name}</td>
					<td>${f_cart.f_cart_quantity}개</td>
					<td><fmt:formatNumber value="${f_cart.f_cart_price}"/>원</td>
					<td><fmt:formatNumber value="${f_cart.sub_total}"/>원</td>
				</tr>
				</c:forEach>
				<tr>
					<td colspan="4" class="align-right"><b>총 구매금액</b></td>
					<td class="align-center">
						<fmt:formatNumber value="${total_price}"/>원
					</td>
				</tr>
			</table>
			<div class="order-title">
				<h2>구매자 정보</h2>
			</div>
			<ul>
				<li>
					<form:label path="buyer_name">구매자명</form:label>
					<form:input path="buyer_name"/>
					<form:errors path="buyer_name" cssClass="error-color"/>
				</li>
				<li>
					<form:label path="buyer_phone">전화번호</form:label>
					<form:input path="buyer_phone" maxlength="15" placeholder="ex) 000-1234-5678 "/>
					<form:errors path="buyer_phone" cssClass="error-color"/>      
				</li>
				<li>
					<form:label path="buyer_email">이메일</form:label>
					<form:input path="buyer_email" type="email" placeholder="ex) giants@gmail.com "/>
					<form:errors path="buyer_email" cssClass="error-color"/>
				</li>
				<li>
					<p>* 구매 후 상품 수령을 위한 정보 및 QR코드가 이메일로 발송됩니다.</p>
				</li>
			</ul>
		</div>
		<!-- 하단 버튼들 -->
		<div class="order-buttons align-center">
			<form:button class="order-btn">주문하기</form:button>
			<input type="button" value="홈으로" class="order-btn" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
		</form:form>
	</div>
	<!-- 내용물 끝 -->
</div>
<!-- 유저 주문하기(푸드) 끝 -->