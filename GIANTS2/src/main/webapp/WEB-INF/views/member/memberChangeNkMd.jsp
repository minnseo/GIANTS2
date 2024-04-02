<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/confirmNkMd.js"></script>
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>닉네임변경</h2>
		<p>자이언츠 닉네임변경 입니다.</p>
	</div>
</div> 
<!-- 닉네임변경 시작 -->
<div class="mypage-form">
	<form:form modelAttribute="memberVO" action="changeNkMd.do" id="member_register">
		<form:errors element="div" cssClass="error-color"/>   
		<ul>
			<li>
				<form:label path="mem_nickname">닉네임</form:label>
				<form:input path="mem_nickname"/>${member.mem_nickname}
				<input type="button" id="confirmNkMd" value="닉네임중복체크" class="default-btn">
				<span id="message_nk"></span><br>
				<form:errors path="mem_nickname" cssClass="error-color"/>
			</li>
		</ul>
		
		
		<div class="align-center">
			<form:button class="default-btn">전송</form:button>
			<input type="button" value="목록" class="default-btn"
				   onclick="location.href='${pageContext.request.contextPath}/member/myPage.do'">
		</div>
	</form:form>
</div>
<!-- 닉네임변경 끝 -->
