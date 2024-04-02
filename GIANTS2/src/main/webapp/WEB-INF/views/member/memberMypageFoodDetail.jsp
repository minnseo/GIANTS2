<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>Foods</h2>
		<p>자이언츠 Food 구매내역 입니다.</p>
	</div>
</div> 
<!-- 주문목록 - 관리자 시작 -->
<div class="mypage-form">
		<div class="member-mypage">
		<h2>결제 정보</h2>
			<br><hr><br>
			<table class="mem-table">
			<tr>
				<td>주문번호</td><td>${f_order.f_order_num}</td>
			</tr>
			<tr>
				<td>구매자명</td><td>${f_order.buyer_name}</td>
			</tr>
			<tr>
				<td>전화번호</td><td>${f_order.buyer_phone}</td>
			</tr>
			<tr>
				<td>이메일</td><td>${f_order.buyer_email}</td>
			</tr>
			<tr>
				<td>결제수단</td><td>${f_order.pg}</td>
			</tr>
			</table>
			<br><br><br>
			<h2>주문 상세 정보</h2>
			<br><hr><br>
			<table class="mem-table">
				<c:forEach var="f_order_detail" items="${list}">
				<tr>
					<td>상품정보</td><td>${f_order_detail.food_name}</td>
				</tr>
				<tr>
					<td>수량</td><td>${f_order_detail.order_quantity}개</td>
				</tr>
				<tr>
					<td>가격</td><td><fmt:formatNumber value="${f_order_detail.food_price}"/>원</td>
				</tr>
				<tr>
					<td>합계</td><td><fmt:formatNumber value="${f_order_detail.food_total}"/>원</td>
				</tr>
				<tr>
					<td><b>총 구매금액</b></td><td><b><fmt:formatNumber value="${f_order.total_price}"/>원</b></td>
				</tr>
				</c:forEach>
			</table>
			<div class="mypage-bottom">
				<c:if test="${f_order.f_order_status==1}">
					<input type="button" value="QR코드" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/food/forder/myFoodQRcode.do?f_order_num=${f_order.f_order_num}'">
				</c:if>
					<input type="button" value="뒤로가기" class="default-btn" onclick="location.href='${pageContext.request.contextPath}/member/memberMypageFoodList.do'">
			</div>
		</div>
		
		</div>

<!-- 주문목록 - 관리자 끝 -->