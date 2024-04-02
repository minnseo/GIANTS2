<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!-- 경기수정 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/NSH/ticket.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<div class="mypage-form">
	<div class="mypage-top2">
		<div class="mypage-top-title">
			<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
			<h2>등급수정</h2>
		</div>
	</div>
	<form:form action="gradeUpdate.do" id="update_grade" method="post" modelAttribute="gradeVO">
		<form:hidden path="grade_num"/>
		<div class="form-list">
		<ul>
			<li>
				<form:label path="title">등급이름</form:label>
				<form:input path="title" autocomplete="off"/><br>
				<form:errors path="title" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="price_week">주중가격</form:label>
				<form:input path="price_week" type="number"/><br>
				<form:errors path="price_week" cssClass="error-color"/>
			</li>
			<li>
				<form:label path="price_weekend">주말가격</form:label>
				<form:input path="price_weekend" type="number"/><br>
				<form:errors path="price_weekend" cssClass="error-color"/>
			</li>
		</ul>
		</div>
		<hr size="0.05" width="100%" noshade>
		<div class="align-center">
			<input type="button" value="삭제" id="grade_delete" class="accept-btn">
			<input type="button" value="목록" onclick="location.href='gradeList.do'" class="gray-btn">
			<form:button class="admin-btn">수정</form:button>
		</div>
		<script type="text/javascript">
		let delete_btn = document.getElementById('grade_delete');
		delete_btn.onclick = function() {
			let choice = confirm('DELETE?');
			if(choice) { location.replace('gradeDelete.do?grade_num=${gradeVO.grade_num}'); }
		};
		</script>
	</form:form>
</div>