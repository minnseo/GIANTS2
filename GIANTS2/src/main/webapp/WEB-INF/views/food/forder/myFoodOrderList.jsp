<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 유저 주문하기(푸드) 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodCss.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/myFoodOrderList.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | 내 주문목록</h2>
	</div>
	<hr noshade="noshade">
	<!-- 상단 필터 시작 -->
	<div class="order-sort">
		<div class="float-left">
			<p>회원님의 푸드 주문목록을 조회하실수 있습니다.</p>
		</div>
		<div class="float-right">
			<form id="orderList_form" action="myFoodOrderList.do" method="get">
				<select id="sort_select" name="sort">
					<option value="2" <c:if test="${sort == 2}">selected</c:if>>모두보기</option>
					<option value="1" <c:if test="${sort == 1}">selected</c:if>>사용 전</option>
					<option value="0" <c:if test="${sort == 0}">selected</c:if>>사용 후</option>
				</select>
			</form>
		</div>
	</div>
	<div class="clear"></div>
	<!-- 목록시작 -->
	<c:if test="${count == 0}">
		<div id="orderList_container">
			<div class="align-center">
				<p>주문한 내역이 존재하지 않습니다.</p>
			</div>
		</div>
	</c:if>
	<c:if test="${count > 0}">
		<div id="orderList_container">
			<table id="orderList_tb" class="bdr">
				<tr>
					<th>번호</th>
					<th>상품명</th>
					<th>주문날짜</th>
					<th>유효기간</th>
					<th>상태</th>
				</tr>
				<c:forEach var="order" items="${list}" varStatus="num">
				<tr>
					<td class="align-center">${num.count}</td>
					<td class="align-center">
						<a href="${pageContext.request.contextPath}/food/forder/myFoodOrderDetail.do?f_order_num=${order.f_order_num}">${order.f_order_name}</a>
					</td>
					<td class="align-center">${order.f_order_regDate}</td>
					<td class="align-center">${order.f_order_expireDate}</td>
					<td class="align-center">
						<c:if test="${order.f_order_status==1}">
							<span class="enable-order"><b>사용가능</b></span>
						</c:if>
						<c:if test="${order.f_order_status==0}">
							<span class="disable-order"><b>사용완료</b></span><br>
							<input type="button" value="리뷰쓰기" onclick="location.href='${pageContext.request.contextPath}/food/foodReviewForm.do?f_order_num=${order.f_order_num}'">
						</c:if>
						<c:if test="${order.f_order_status==2}">
							<span class="disable-order"><b>사용완료</b></span><br>
						</c:if>
						<c:if test="${order.f_order_status==9}">
							<span class="disable-order"><b>주문취소</b></span>
						</c:if>
					</td> 
				</tr>
				</c:forEach>
			</table>
			<div class="align-center">${page}</div>
		</div>
	</c:if>
	<!-- 내용물 끝 -->
</div>
<!-- 유저 주문하기(푸드) 끝 -->