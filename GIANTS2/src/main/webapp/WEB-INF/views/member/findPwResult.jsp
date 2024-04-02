<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/profile.js"></script>
<div>
	<div class="mypage-top2">
		<div class="mypage-top-title">
			<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
			<h2>비밀번호찾기</h2>
			<p>자이언츠 비밀번호찾기 입니다.</p>
		</div>
	</div>
	<div class="member-mypage">
	<ul>
		<li>자이언츠 임시비밀번호 입니다.</li>
		<li>비밀번호 : ${new_passwd}</li>
	</ul>
	<input type="button" value="로그인" class="bottom-btn"
			       onclick="location.href='${pageContext.request.contextPath}/member/login.do'">
	</div>
</div>
