<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 티켓정보 --> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/NSH/ticket.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ticket.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/qrcode.js"></script>

<div class="mypage-form2">
	<div class="mypage-top2">
		<div class="mypage-top-title">
			<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
			<h2>티켓정보</h2>
		</div>
	</div>
	<c:if test="${ticket.order_status != 0 && ticket.ticket_status == 1 && user.mem_auth != 9}">
	<div class="ticket-info align-right">
		<input type="image" id="ticket_download" src="${pageContext.request.contextPath}/images/downloads.png">
	</div>
	</c:if>
	<div class="ticket-info2">
		<input type="hidden" value="${ticket.ticket_num}" id="ticketNum">
		<div class="ticket-content">
			<div class="ticket-ul">
				<ul>
					<li>${ticket.ticket_num}</li>
					<li>롯데 VS ${ticket.game_title}</li>
					<li>사직야구장</li>
					<li>${ticket.game_date} ${ticket.game_time}</li>
				</ul>
			</div>
			<c:if test="${ticket.order_status == 1 && ticket.ticket_status == 1}">
			<div class="ticket-qr">
				<input type="hidden" value="http://localhost:8000${ticket.qrlink}" id="qrlink">
				<div id="qrcode"></div>
			</div>
			</c:if>
		</div>
		
		<div class="ticket-content2">
			결제금액 <fmt:formatNumber value="${ticket.total_price}"/>원
		</div>
	</div>
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
				<c:if test="${user.mem_auth != 9}">
				<tr>
					<td>수령방법</td>
					<td>무인발권기 발권<br>또는 경기 당일 모바일티켓 발권</td>
				</tr>
				</c:if>
			</table>
		</div>
	</div>
	<div class="ticket-info4">
		<table class="ticket-table">
			<tr>
				<td>좌석</td>
				<td id="status_info">
					<span class="gradeTitle">${grade.title}</span>
					<c:forEach var="detail" items="${list}">
						 <span class="seat-info">${detail.seat_info} </span>
					</c:forEach>
				</td>
			</tr>
		</table>
		<c:if test="${user.mem_auth == 9}">
		<table class="ticket-table">
			<tr>
				<td>QR승인</td>
				<td><a href="http://localhost:8000${ticket.qrlink}">http://localhost:8000${ticket.qrlink}</a></td>
			</tr>
		</table>
		</c:if>
	</div>
	<div class="ticket-info5 align-center">
		<input type="hidden" name="ticket_num" value="${ticket.ticket_num}">
		<c:if test="${user.mem_auth != 9}">
		<input type="button" value="목록" class="gray-btn big" onclick="location.href='${pageContext.request.contextPath}/member/memberMypageTicketList.do'">
		</c:if>
		<c:if test="${user.mem_auth == 9}">
		<input type="button" value="목록" class="gray-btn big" onclick="location.href='${pageContext.request.contextPath}/member/adminMypageTicket.do'">
		</c:if>
		<c:if test="${ticket.order_status != 0 && ticket.ticket_status == 1 && user.mem_auth != 9}">
		<input type="button" value="주문취소" id="delete_torder" class="accept-btn big">
		</c:if>
	</div>
	<script type="text/javascript">
	$(function(){
		let qrcode = new QRCode(document.getElementById("qrcode"),{
			width:100,
			height:100
		});
		
		function makeCode(){
			let qrlink = document.getElementById("qrlink");
			qrcode.makeCode(qrlink.value);
		}
		makeCode();
	});
		let delete_btn = document.getElementById('delete_torder');
		delete_btn.onclick = function() {
			let choice = confirm('주문을 취소하시겠습니까??');
			if(choice) { location.replace('deleteTorder.do?ticket_num=${ticket.ticket_num}'); }
		};
		</script>
</div>