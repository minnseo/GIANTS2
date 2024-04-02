<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 배송상태수정 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>배송상태수정</h2>
		<p>자이언츠 굿즈 배송상태수정 입니다.</p>
	</div>
</div>
<div class="page-main">
	<h2>배송상태수정</h2>
	<form:form action="admin_status.do" id="order_status" modelAttribute="orderVO">
		<form:hidden path="order_num"/>
		<ul>
			<li>
				<label>배송상태</label>
				<c:if test="${orderVO.order_status != 5}">
				<form:radiobutton path="status" value="1"/>배송대기	
				<form:radiobutton path="status" value="2"/>배송준비중
				<form:radiobutton path="status" value="3"/>배송중
				<form:radiobutton path="status" value="4"/>배송완료
				</c:if>
				<form:radiobutton path="status" value="5"/>주문취소
			</li>
		</ul>   
		<div class="align-center">
			<c:if test="${orderVO.status != 5}">
			<input type="submit" value="수정">
			</c:if>
			<input type="button" value="목록" onclick="location.href='admin_list.do'">
		</div>                                        
	</form:form>
</div>
<!-- 배송상태수정 끝 -->






