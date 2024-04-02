<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 좌석등급 목록 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/NSH/ticket.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<div class="mypage-form">
	<div class="mypage-top2">
		<div class="mypage-top-title">
			<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
			<h2>좌석관리</h2>
		</div>
	</div>
	<div class="align-right">
		<input type="button" value="+" onclick="location.href='gradeWrite.do'" class="admin-btn small">
	</div>
	<c:if test="${count == 0}">
	<div class="result-display">등록된 좌석등급 無</div>
	</c:if>
	<c:if test="${count > 0}">
	<table id="grade_list">
		<tr>
			<th>등급번호</th>
			<th>등급명</th>
			<th>주중가격</th>
			<th>주말가격</th>
			<th>좌석개수</th>
			<th></th>
		</tr>
		<c:forEach var="grade" items="${list}">
		<tr>
			<td>${grade.grade_num}</td>
			<td><a href="seatList.do?grade_num=${grade.grade_num}">${grade.title}</a></td>
			<td><fmt:formatNumber value="${grade.price_week}"/>원</td>
			<td><fmt:formatNumber value="${grade.price_weekend}"/>원</td>
			<td><fmt:formatNumber value="${grade.quantity}"/>개</td>
			<td><input type="button" value="수정" onclick="location.href='gradeUpdate.do?grade_num=${grade.grade_num}'" class="admin-btn small"></td>
		</tr>
		</c:forEach>
	</table>
	</c:if>
</div>