<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<div class="mypage-top">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>비밀번호찾기</h2>
		<p>자이언츠 기업회원 비밀번호찾기 입니다.</p>
	</div> 
</div>
<!-- 아이디찾기 시작 -->
<div class="page-main">
	<form:form modelAttribute="memberVO" action="findPwCp.do" id="member_findPw">
		<div class="register-box">
		<ul>
			<li>
				<form:label path="mem_id">아이디</form:label>
				<form:input path="mem_id"/><br>
				<form:errors path="mem_id" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="comp_owner">사업자명</form:label>
				<form:input path="comp_owner"/><br>
				<form:errors path="comp_owner" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="comp_phone">전화번호</form:label>
				<form:input path="comp_phone" placeholder="숫자11자"/>
				<form:errors path="comp_phone" cssClass="error-color"/>
 			</li>
 			<li>
				<form:label path="comp_email">이메일</form:label>
				<form:input path="comp_email"/>
				<form:errors path="comp_email" cssClass="error-color"/>
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
