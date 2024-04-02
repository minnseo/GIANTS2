<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 결제완료 --> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/NSH/ticket.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ticket.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>

<div class="page-main">
	<div class="main-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>결제완료</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<div class="ticket-info1">
		<form action="ticketReserved.do" method="post" id="ticket_reserved">
			<input type="hidden" name="ticket_num" value="${ticket.ticket_num}">
			<div class="reserved1">
				<img src="${pageContext.request.contextPath}/images/ticket_checked.png" width="32px" height="32px"><br>
				주문번호 ${ticket.ticket_num}<br>
				예매가 정상적으로 완료되었습니다.
			</div>
			<div class="reserved2">
				<input type="button" value="예매내역" class="accept-btn big" onclick="location.href='ticketInfo.do?ticket_num=${ticket.ticket_num}'">
				<input type="button" value="경기목록" class="admin-btn big" onclick="location.href='gameList.do'">
			</div>
		</form>
	</div>
</div>