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
			<h2>${seat.seat_block}블록 | 좌석관리</h2>
		</div>
	</div>
	<form action="seatEdit.do" method="post" id="seat_edit">
		<input type="hidden" name="grade_num" value="${seat.grade_num}" id="admin_grade">
		<input type="hidden" name="seat_num" value="${seat.seat_num}" id="admin_seat">
		<input type="hidden" name="seat_block" value="${seat.seat_block}" id="admin_block">
		<input type="hidden" name="seat_row" value="${seat.seat_row}" id="admin_row">
		<input type="hidden" name="seat_col" value="${seat.seat_col}" id="admin_col">
		<div class="select-ticket">
			<div class="select-left">
				<div class="admin_seatBox"></div>
			</div>
			<div class="select-right">
				<div class="selected-seat">
					<hr width="100%" class="color-red" noshade>
					<table class="seat-table">
						<tr>
							<th colspan="2">선택된 좌석정보</th>
						</tr>
					</table>
				</div>
				<div class="edit-radioBox">
					<hr width="100%" class="color-red" noshade>
					<table>
						<tr>
							<th colspan="2">좌석상태</th>
						</tr>
						<tr>
							<td><input type="radio" name="seat_auth" value="0">사용가능</td>
							<td><input type="radio" name="seat_auth" value="2">사용불가</td>
						</tr>
					</table>
				</div>
				<div class="edit-btnGroup">
						<input type="button" value="목록" onclick="location.href='seatList.do?grade_num=${seat.grade_num}'" class="gray-btn">
						<input type="submit" value="변경" class="accept-btn">
					</div>
			</div>
		</div>
	</form>
</div>