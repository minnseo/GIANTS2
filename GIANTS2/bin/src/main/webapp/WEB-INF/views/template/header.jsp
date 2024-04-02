<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 상단 S -->
<h2 class="align-center">SpringPage</h2>
<div class="align-right">
	<a href="${pageContext.request.contextPath}/board/list.do">게시판</a>
	
	<!-- Profile Image -->
	<c:if test="${!empty user}">
	<img src="${pageContext.request.contextPath}/member/photoView.do" width="25" height="25" class="my-photo">
	</c:if>
	
	<!-- 닉네임이 있으면 닉네임, 없으면 ID 활성화 -->
	<c:if test="${!empty user && !empty user.nick_name}">
	<b>[ <span class="user_name">${user.nick_name}</span> ]</b>
	</c:if>
	<c:if test="${!empty user && empty user.nick_name}">
	<b>[ <span class="user_name">${user.id}</span> ]</b>
	</c:if>
	
	<!-- MyPage : 일반회원일 경우 활성화 -->
	<c:if test="${!empty user && user.auth == 2}">
	<a href="${pageContext.request.contextPath}/member/myPage.do">MyPage</a>
	</c:if>
	
	<c:if test="${!empty user}">
	<a href="${pageContext.request.contextPath}/member/logout.do">Logout</a>
	</c:if>
	
	<!-- Login하지 않은 경우 -->
	<c:if test="${empty user}">
	<a href="${pageContext.request.contextPath}/member/registerUser.do">회원가입</a>
	<a href="${pageContext.request.contextPath}/member/login.do">Login</a>
	</c:if>
	<c:if test="${empty user || user.auth < 9}">
	<a href="${pageContext.request.contextPath}/main/main.do">HOME</a>
	</c:if>
	
	<!-- [관리자]HOME -->
	<c:if test="${!empty user && user.auth == 9}">
	<a href="${pageContext.request.contextPath}/main/admin.do">HOME</a>
	</c:if>
</div>
<!-- 상단 E -->