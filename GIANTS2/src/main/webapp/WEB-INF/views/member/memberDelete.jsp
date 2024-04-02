<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>회원탈퇴</h2>
		<p>자이언츠 회원탈퇴 입니다.</p>
	</div>
</div> 
<!-- 회원탈퇴 폼 시작 -->
<div class="mypage-form">
	<form:form modelAttribute="memberVO" action="deleteMember.do" id="member_delete">
		<form:errors element="div" cssClass="error-color"/>
		<ul>
			<li>
				<form:label path="mem_id">아이디</form:label>
	            <form:input path="mem_id"/>
	            <form:errors path="mem_id" cssClass="error-color"/> <!-- 아이디 또는 비밀번호 불일치만 출력 -->
			</li>
			<li>
				<form:label path="passwd">비밀번호</form:label>
	            <form:password path="passwd"/>
			</li>
			<li>
		</ul>
		<div class="mypage-bottom">
			<form:button class="bottom-btn">전송</form:button>
			<input type="button" value="목록" class="bottom-btn"
				   onclick="location.href='myPage.do'">
		</div>
	</form:form>
</div>
<!-- 회원탈퇴 폼 끝 -->
