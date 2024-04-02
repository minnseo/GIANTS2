<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/login.js"></script>

<div class="mypage-top">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>로그인</h2>
		<p>자이언츠 로그인 입니다.</p>
	</div>
</div> 
<!-- 로그인폼시작 -->
<div class="login-main">
	<form:form modelAttribute="memberVO" action="login.do" id="member_login">
		<!-- 로그인폼 -->
		<div class="login-form">
			<img src="${pageContext.request.contextPath}/images/로그인로고.png">
			<p>로그인을 하시면 롯데 자이언츠의<br>다양한 이벤트참여와 혜택을 누리실 수 있습니다.</p>
			<div class="login">
				<form:errors element="div" cssClass="error-color" />
				<ul>
					<li>
						<form:label path="mem_id">아이디</form:label>
						<form:input path="mem_id" placeholder="아이디"
									cssClass="form-input" autocomplete="off"/>
			            <form:errors path="mem_id" element="div" cssClass="error-color" /></li>
					<li>
						<form:label path="passwd">비밀번호</form:label>
						<form:password path="passwd" placeholder="비밀번호"
										cssClass="form-input" autocomplete="off" />
			            <form:errors path="passwd" element="div" cssClass="error-color" />
					</li>
					<li>
						<input type="checkbox" name="auto" id="auto">로그인유지
					</li>
				</ul>
				<div class="autologin">
					<form:button class="login-btn">로그인</form:button>
				</div>
			</div>
		</div>
		<!-- 회원가입 / 아이디 / 비밀번호 찾기 -->
		<div class="login-sub">
			<ul>
				<li class="mypage-bottom">
					아직 롯데자이언츠 회원이 아니신가요?
					<input type="button" value="회원가입" class="login-sub-btn default-btn2"
							onclick="location.href='${pageContext.request.contextPath}/member/registerCommon.do'">
				</li>
				<li><hr size="0.05" width="100%" noshade></li>
				<li class="mypage-bottom">
					아이디나 비밀번호를 잊으셨나요?<br>
					일반회원 >>
					<input type="button" value="아이디찾기" class="login-sub-btn default-btn2"
							onclick="location.href='${pageContext.request.contextPath}/member/findId.do'">
					<input type="button" value="비밀번호찾기" class="login-sub-btn default-btn2"
							onclick="location.href='${pageContext.request.contextPath}/member/findPw.do'"><br>
					기업회원 >>
					<input type="button" value="아이디찾기" class="login-sub-btn default-btn2"
							onclick="location.href='${pageContext.request.contextPath}/member/findIdCp.do'">
					<input type="button" value="비밀번호찾기" class="login-sub-btn default-btn2"
							onclick="location.href='${pageContext.request.contextPath}/member/findPwCp.do'">		
				</li>
			</ul>
		</div>
	</form:form>
</div>
<!-- 로그인폼끝 -->