<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!-- 경기등록 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/NSH/ticket.css">
<div class="page-main">
	<div class="main-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>경기등록</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<form:form action="gameWrite.do" id="insert_game" method="post" modelAttribute="gameVO">
		<div class="form-list">
		<ul>
			<li>
				<form:label path="game_date">경기일</form:label>
				<form:input path="game_date" placeholder="YYYY-MM-DD 형식으로 작성" autocomplete="off"/><br>
				<form:errors path="game_date" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="game_time">시작시간</form:label>
				<form:input path="game_time" placeholder="HH:MM 형식으로 작성" autocomplete="off"/><br>
				<form:errors path="game_time" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="game_team">상대팀</form:label>
				<form:radiobutton path="game_team" value="landers"/>SSG
				<form:radiobutton path="game_team" value="heroes"/>키움
				<form:radiobutton path="game_team" value="twins"/>LG
				<form:radiobutton path="game_team" value="wiz"/>KT
				<form:radiobutton path="game_team" value="tigers"/>KIA
				<form:radiobutton path="game_team" value="dinos"/>NC
				<form:radiobutton path="game_team" value="lions"/>삼성
				<form:radiobutton path="game_team" value="bears"/>두산
				<form:radiobutton path="game_team" value="eagles"/>한화<br>
				<form:errors path="game_team" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="game_week">주중/주말</form:label>
				<form:radiobutton path="game_week" value="0"/>주중
				<form:radiobutton path="game_week" value="1"/>주말
			</li>
		</ul>
		</div>
		<hr size="0.05" width="100%" noshade>
		<div class="align-center">
			<input type="button" value="이전" onclick="location.href='gameList.do'" class="gray-btn">
			<form:button class="admin-btn">등록</form:button>
		</div>
	</form:form>
</div>