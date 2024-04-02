<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<!-- 등급상세 및 좌석목록 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/NSH/ticket.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/seat.js"></script>
<div class="mypage-form">
	<div class="mypage-top2">
		<div class="mypage-top-title">
			<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
			<h2>${grade.title}</h2>
		</div>
	</div>
	<div> 
		<div class="align-right">
			<input type="button" value="+" id="open_seatForm" class="admin-btn small">
			<input type="button" value="목록" onclick="location.href='gradeList.do'" class="gray-btn small">
		</div>
		<form action="seatWrite.do" id="seat_write" method="post" style="display:none;">
			<input type="hidden" name="grade_num" id="grade_num" value="${grade.grade_num}">
			<ul>
				<li>
					<label for="seat_block">블럭번호</label>
					<input type="number" name="seat_block" id="seat_block">
					<span id="block_error" class="error-color"></span>
				</li>
				<li>
					<label for="seat_row">좌석행</label>
					<input type="checkbox" value="selectRow" id="check_row">All
					<input type="checkbox" name="seat_row" value="A" class="seat-row">A
					<input type="checkbox" name="seat_row" value="B" class="seat-row">B
					<input type="checkbox" name="seat_row" value="C" class="seat-row">C
					<input type="checkbox" name="seat_row" value="D" class="seat-row">D
					<input type="checkbox" name="seat_row" value="E" class="seat-row">E
					<input type="checkbox" name="seat_row" value="F" class="seat-row">F
					<input type="checkbox" name="seat_row" value="G" class="seat-row">G
					<span id="row_error" class="error-color"></span>
				</li>
				<li>
					<label for="seat_col">좌석열</label>
					<input type="checkbox" value="selectCol" id="check_col">All
					<input type="checkbox" name="seat_col" value="1" class="seat-col">1
					<input type="checkbox" name="seat_col" value="2" class="seat-col">2
					<input type="checkbox" name="seat_col" value="3" class="seat-col">3
					<input type="checkbox" name="seat_col" value="4" class="seat-col">4
					<input type="checkbox" name="seat_col" value="5" class="seat-col">5
					<input type="checkbox" name="seat_col" value="6" class="seat-col">6
					<input type="checkbox" name="seat_col" value="7" class="seat-col">7
					<input type="checkbox" name="seat_col" value="8" class="seat-col">8
					<input type="checkbox" name="seat_col" value="9" class="seat-col">9
					<input type="checkbox" name="seat_col" value="10" class="seat-col">10
					<span id="col_error" class="error-color"></span>
				</li>
				<li>
					<label for="seat_quantity">좌석개수</label>
					<input type="number" name="seat_quantity" id="seat_quantity" value="">
				</li>
				<li>
					<input type="submit" value="등록" class="admin-btn small">
					<input type="button" value="취소" id="close_seatForm" class="gray-btn small">
				</li>
			</ul>
		</form>
		<c:if test="${count == 0}">
		<div>관리할 블럭 無</div>
		</c:if>
		<c:if test="${count > 0}">
		<div class="seat-list">
			<table>
				<tr>
					<th>블록번호</th>
					<th>행</th>
					<th>열</th>
					<th></th>
				</tr>
				<c:forEach var="seat" items="${list}">
				<tr>
					<td>${seat.seat_block}</td>
					<td>${seat.seat_row}</td>
					<td>${seat.seat_col}</td>
					<td>
						<input type="hidden" name="seat_num" value="${seat.seat_num}" id="seatNum">
						<input type="button" value="수정" data-seatblock="${seat.seat_block}" data-quantity="${seat.seat_quantity}" class="seat-update admin-btn small">
						<input type="button" value="관리" onclick="location.href='seatEditForm.do?seat_num=${seat.seat_num}'" class="accept-btn small">
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		<div class="seatform-update"></div>
		</c:if>
	</div>
</div>