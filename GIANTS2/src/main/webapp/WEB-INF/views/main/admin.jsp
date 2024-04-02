<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 관리자 Main S -->
<div class="page-main">
	<h2>회원목록</h2>
	<table class="striped-table">
		<tr>
			<th>ID</th>
			<th>이름</th>
			<th>전화번호</th>
			<th>EMAIL</th>
			<th>가입일</th>
			<th>권한</th>
		</tr>
		<c:forEach var="memberList" items="${memberList}">
		<tr class="align-center">
			<td>
				<c:if test="${memberList.auth == 0}">${memberList.id}</c:if>
				<c:if test="${memberList.auth > 0}"><a href="${pageContext.request.contextPath}/member/admin_update.do?mem_num=${memberList.mem_num}">${memberList.id}</a></c:if>
			</td>
			<td>${memberList.name}</td>
			<td>${memberList.phone}</td>
			<td>${memberList.email}</td>
			<td>${memberList.reg_date}</td>
			<td>
				<c:if test="${memberList.auth == 0}">탈퇴</c:if>
				<c:if test="${memberList.auth == 1}">정지</c:if>
				<c:if test="${memberList.auth == 2}">일반</c:if>
				<c:if test="${memberList.auth == 9}">관리</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
</div>
<!-- 관리자 Main E -->