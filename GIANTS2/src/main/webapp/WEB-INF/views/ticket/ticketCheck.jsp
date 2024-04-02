<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 예매확인 --> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/NSH/ticket.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ticket.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ticket.order.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>

<div class="page-main">
	<div class="main-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>예매확인</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<div class="check-info">
		<%-- 왼쪽 절반 --%>
		<div class="select-left" style="background:#f1f1f1;">
			<div class="left-no1">
				<h2>수령방법</h2>
				<div class="back-white">
					<div id="border_text">현장수령</div>
				</div>
			</div>
			<div class="left-no2">
				<h2>주문자 정보</h2>
				<div class="back-white">
					<table class="order-info">
						<tr>
							<th>이름</th>
							<td>${seatVO.detailVO.mem_name}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${seatVO.detailVO.mem_phone}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${seatVO.detailVO.mem_email}</td>
						</tr>
					</table>
					<input type="hidden" value="${seatVO.detailVO.mem_name}" id="mem_name">
					<input type="hidden" value="${seatVO.detailVO.mem_phone}" id="mem_phone">
					<input type="hidden" value="${seatVO.detailVO.mem_email}" id="mem_email">
				</div>
			</div>
			<div class="left-no3">
				<h2>예매자 확인</h2>
				<input type="checkbox" name="check_info" id="check_info1"> KBO리그 SAFE 캠페인에 동의합니다.<br>
				<input type="checkbox" name="check_info" id="check_info2"> 프로 스포츠 암표 매매 행위에 따른 제재사항에 동의합니다.
			</div>
		</div>
		<%-- 오른쪽 절반 --%>
		<div class="select-right">
			<div class="select-gameInfo">
				<hr width="100%" class="color-red" noshade>
				<div class="game-information">
					<h2>경기정보</h2>
					<div class="game-logo">
						<img src="${pageContext.request.contextPath}/images/giants.png"> VS <img src="${pageContext.request.contextPath}/images/${gameVO.game_team}.png">
					</div>	
					롯데 VS <c:if test="${gameVO.game_team == 'landers'}">
						   <input type="hidden" name="game_team" value="SSG" id="team_title">SSG
						   </c:if>
						   <c:if test="${gameVO.game_team == 'heroes'}">
						   <input type="hidden" name="game_team" value="키움" id="team_title">키움
						   </c:if>
						   <c:if test="${gameVO.game_team == 'twins'}">
						   <input type="hidden" name="game_team" value="LG" id="team_title">LG
						   </c:if>
						   <c:if test="${gameVO.game_team == 'wiz'}">
						   <input type="hidden" name="game_team" value="KT" id="team_title">KT
						   </c:if>
						   <c:if test="${gameVO.game_team == 'tigers'}">
						   <input type="hidden" name="game_team" value="KIA" id="team_title">KIA
						   </c:if>
						   <c:if test="${gameVO.game_team == 'dinos'}">
						   <input type="hidden" name="game_team" value="NC" id="team_title">NC
						   </c:if>
						   <c:if test="${gameVO.game_team == 'lions'}">
						   <input type="hidden" name="game_team" value="삼성" id="team_title">삼성
						   </c:if>
						   <c:if test="${gameVO.game_team == 'bears'}">
						   <input type="hidden" name="game_team" value="두산" id="team_title">두산
						   </c:if>
						   <c:if test="${gameVO.game_team == 'eagles'}">
						   <input type="hidden" name="game_team" value="한화" id="team_title">한화
						   </c:if><br>
					사직야구장<br>
					${gameVO.game_date} ${gameVO.game_time}<br>
					<input type="hidden" value="${gameVO.game_date}" id="game_date">
					<input type="hidden" value="${gameVO.game_time}" id="game_time">
				</div>
				<div class="ticketInfo">
					<h2>좌석정보</h2>
					<div id="seatInfo">
						<input type="hidden" name="title" id="grade_title" value="${gradeVO.title}">
						<c:forEach var="seat" items="${seatVO.seat_info}">
						<span class="seat-info" data-seatInfoCheck="${seat}">${seat} </span><br>
						</c:forEach>
					</div>
				</div>
				<div class="price-information">
					<table>
						<tr class="price-total">
							<td>결제금액</td>
							<td>
								<c:if test="${gameVO.game_state == 0}">${gradeVO.price_week}</c:if>
								<c:if test="${gameVO.game_state == 1}">${gradeVO.price_weekend}</c:if>
							</td>
						</tr>
					</table>
				</div>
				<hr width="100%" class="color-red" noshade>
				<div class="group-btn">
					<input type="hidden" name="check_num" value="${checkVO.check_num}" id="check_num">
					<input type="button" value="이전" class="gray-btn big" onclick="location.href='ticketMain.do?game_num=${gameVO.game_num}'">
					<input type="button" value="결제" class="accept-btn big" id="ticket_kakao">
					<input type="hidden" value="${gameVO.game_num}" id="game_num">
					<input type="hidden" value="${seatVO.grade_num}" id=grade_num>
				</div>	
			</div>
		</div>
	</div>
</div>