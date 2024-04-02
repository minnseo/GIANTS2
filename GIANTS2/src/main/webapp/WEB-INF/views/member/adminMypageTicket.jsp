<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/NSH/ticket.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>티켓관리</h2>
		<p>자이언츠 티켓관리 입니다.</p>
	</div>
</div>
<!-- 마이페이지 티켓구매내역 시작 --> 
<div class="mypage-form">
	<form action="adminMypageTicket.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">SELECTED</c:if>>상대팀</option>
					<option value="2" <c:if test="${param.keyfield == 2}">SELECTED</c:if>>구매자명</option>
					<option value="3" <c:if test="${param.keyfield == 3}">SELECTED</c:if>>경기일</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기" class="default-btn">
				<input type="button" value="목록" onclick="location.href='adminMypageTicket.do'" class="default-btn">
			</li>
		</ul>
	</form>
	<c:if test="${count == 0}">
		<div class="result-display">Ticket구매내역 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<p class="Mypage-p">*티켓번호 클릭시 상세페이지로 이동</p>
		<table class="striped-table">
			<tr>
				<th>티켓번호</th>
				<th>구매자명</th>
				<th>상대팀</th>
				<th>일시</th>
				<th>수량</th>
				<th>결제금액</th>
				<th>상태</th>
			</tr>
			<c:forEach var="ticket" items="${list}">
				<tr>
					<td class="align-center">
						<a href="${pageContext.request.contextPath}/ticket/ticketInfo.do?ticket_num=${ticket.ticket_num}">${ticket.ticket_num}</a>
					</td>
					<td class="align-center">${ticket.order_name}</td>
					<td class="align-center">${ticket.game_title}</td>
					<td class="align-center">${ticket.game_date}</td>
					<td class="align-center">${ticket.ticket_quantity}</td>
					<td class="align-center"><fmt:formatNumber value="${ticket.total_price}"/>원</td>
					<td class="align-center">
						<c:if test="${ticket.ticket_status == 0}"><span style="color:#dd032f;"><b>주문취소</b></span></c:if>
						<c:if test="${ticket.ticket_status == 1}"><span style="color:#052345;"><b>주문완료</b></span></c:if>
						<c:if test="${ticket.ticket_status == 2}"><span style="color:#dd032f;"><b>경기취소</b></span></c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div class="form-page">${page}</div>
	</c:if>
</div>