<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/changePasswd.js"></script>
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>비밀번호변경</h2>
		<p>자이언츠 비밀번호변경 입니다.</p>
	</div>
</div> 
<!-- 비밀번호변경 시작 -->
<div class="mypage-form">
	<form:form modelAttribute="memberVO" action="changePasswd.do" id="member_change">
		<form:errors element="div" cssClass="error-color"/>   
		<ul>
			<li>
				<form:label path="now_passwd">현재 비밀번호</form:label>
				<form:password path="now_passwd"/>
				<form:errors path="now_passwd" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="passwd">새 비밀번호</form:label>
				<form:password path="passwd"/>
				<form:errors path="passwd" cssClass="error-color"/>
			</li>
			<li>
				<label for="confirm_passwd">새 비밀번호 확인</label>
				<input type="password" id="confirm_passwd">
				<span id="message_id"></span>
			</li>
		</ul>
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="목록" class="default-btn"
				   onclick="location.href='${pageContext.request.contextPath}/member/myPage.do'">
		</div>
	</form:form>
</div>
<!-- 비밀번호변경 끝 -->
