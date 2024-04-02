<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/NSH/ticket.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodCss.js"></script>
<div class="mypage-form">
	<div class="mypage-top2">
		<div class="mypage-top-title">
			<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
			<h2> 티켓 | 주문승인</h2>
		</div>
	</div>
	<hr noshade="noshade">
	<!-- 내용물 시작 -->
	<div class="orderDetail-container">
		<div class="ticket-info3">
			<div class="info3-left">
				<table class="ticket-table">
					<tr>
						<td>예매일시</td>
						<td>${ticket.ticket_date}</td>
					</tr>
					<tr>
						<td>예매번호</td>
						<td>${ticket.ticket_num}</td>
					</tr>
					<tr>
						<td>경기명</td>
						<td>${ticket.game_title}</td>
					</tr>
					<tr>
						<td>관람장소 및 일시</td>
						<td>사직야구장 ${ticket.game_date} ${ticket.game_time}</td>
					</tr>
				</table>
			</div>
			<div class="info3-right">
				<table class="ticket-table">
					<tr>
						<td>예매자</td>
						<td>${ticket.order_name}</td>
					</tr>
					<tr>
						<td>인원수</td>
						<td>${ticket.ticket_quantity}명</td>
					</tr>
					<tr>
						<td>총 결제내역</td>
						<td>${ticket.pg} <fmt:formatNumber value="${ticket.total_price}"/>원</td>
					</tr>
				</table>
			</div>
		</div>
		<div class="ticket-info5 align-center">
			<input type="hidden" name="ticket_num" value="${ticket.ticket_num}">
			<input type="button" value="목록" class="gray-btn big" onclick="location.href='${pageContext.request.contextPath}/member/adminMypageTicket.do'">
		</div>
	</div>
	<!-- 내용물 끝 -->
</div>
<!-- 기업 (푸드)주문승인 끝 -->