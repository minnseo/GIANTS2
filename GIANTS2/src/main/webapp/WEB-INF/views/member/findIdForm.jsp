<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<div class="mypage-top">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>아이디찾기</h2>
		<p>자이언츠 일반회원 아이디찾기 입니다.</p>
	</div> 
</div>
<!-- 아이디찾기 시작 -->
<div class="page-main">
	<form:form modelAttribute="memberVO" action="findId.do" id="member_findId">
		<div class="register-box">
		<ul>
			<li>
				<form:label path="mem_name">이름</form:label>
				<form:input path="mem_name"/><br>
				<form:errors path="mem_name" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="mem_phone">전화번호</form:label>
				<form:input path="mem_phone" placeholder="숫자11자" autocomplete="off"/>
				<form:errors path="mem_phone" cssClass="error-color"/>
 			</li>
		</ul>
		</div>
		<div class="align-center">
			<form:button class="bottom-btn">찾기</form:button>
			<input type="button" value="로그인" class="bottom-btn"
			       onclick="location.href='${pageContext.request.contextPath}/member/login.do'">
		</div>
	</form:form>
</div>
<!-- 아이디찾기 끝 -->
