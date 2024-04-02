<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!-- 경기목록 --> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/NSH/ticket.css">
<div class="page-main">
	<div class="main-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>경기선택</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<c:if test="${user.mem_auth == 9}">
	<div class="align-right">
		<input type="button" value="경기등록" onclick="location.href='gameWrite.do'" class="admin-btn">
	</div>
	</c:if>
	<c:if test="${count == 0}">
	<div class="result-display">예매중인 경기가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table id="game_list">
		<tr>
			<th>날짜</th>
			<th>시간</th>
			<th>VS</th>
			<th>구장</th>
			<th>예매</th>
			<c:if test="${user.mem_auth == 9}">
			<th>관리자</th>
			</c:if>
		</tr>
		<c:if test="${user.mem_auth == 9}">
			<c:forEach var="admin" items="${admin}">
			<tr>
				<td>${admin.game_date}</td>
				<td>${admin.game_time}</td>
				<td>
					<img src="${pageContext.request.contextPath}/images/${admin.game_team}.png">
				</td>
				<td>사직야구장</td>
				<td>
					<c:if test="${admin.game_state == 0}">
					<input type="button" value="준비중" class="gray-btn" readonly="readonly">
					</c:if>
					<c:if test="${admin.game_state == 1}">
					<input type="button" value="예매" onclick="location.href='ticketMain.do?game_num=${admin.game_num}'" class="accept-btn">
					</c:if>
					<c:if test="${admin.game_state == 2}">
					<input type="button" value="매진" class="gray-btn" readonly="readonly">
					</c:if>
					<c:if test="${admin.game_state == 3}">
					<input type="button" value="취소" class="gray-btn" readonly="readonly">
					</c:if>
					<c:if test="${admin.game_state == 4}">
					<input type="button" value="경기종료" class="gray-btn" readonly="readonly">
					</c:if>
				</td>
				<c:if test="${user.mem_auth == 9}">
				<td>
					<input type="button" value="수정" onclick="location.href='gameUpdate.do?game_num=${admin.game_num}'" class="admin-btn small">
				</td>
				</c:if>
			</tr>
			</c:forEach>
		</c:if>
		<c:if test="${user.mem_auth != 9}">
			<c:forEach var="game" items="${list}">
			<tr>
				<td>${game.game_date}</td>
				<td>${game.game_time}</td>
				<td>
					<img src="${pageContext.request.contextPath}/images/${game.game_team}.png">
				</td>
				<td>사직야구장</td>
				<td>
					<c:if test="${game.game_state == 0}">
					<input type="button" value="준비중" class="gray-btn" readonly="readonly">
					</c:if>
					<c:if test="${game.game_state == 1}">
					<input type="button" value="예매" onclick="location.href='ticketMain.do?game_num=${game.game_num}'" class="accept-btn">
					</c:if>
					<c:if test="${game.game_state == 2}">
					<input type="button" value="매진" class="gray-btn" readonly="readonly">
					</c:if>
					<c:if test="${game.game_state == 3}">
					<input type="button" value="취소" class="gray-btn" readonly="readonly">
					</c:if>
					<c:if test="${game.game_state == 4}">
					<input type="button" value="경기종료" class="gray-btn" readonly="readonly">
					</c:if>
				</td>
				<c:if test="${user.mem_auth == 9}">
				<td>
					<input type="button" value="수정" onclick="location.href='gameUpdate.do?game_num=${game.game_num}'" class="admin-btn small">
				</td>
				</c:if>
			</tr>
			</c:forEach>
		</c:if>
	</table>
	</c:if>
</div>