<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<!-- 주문목록 - 관리자 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>굿즈주문목록</h2>
		<p>자이언츠 굿즈주문목록 입니다.</p>
	</div>
</div>
<div class="mypage-form">
	<form action="admin_list.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>주문번호</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>ID</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>상품명</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword"
				                     value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기">
				<input type="button" value="목록" 
				   onclick="location.href='admin_list.do'">
			</li>
		</ul>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 주문정보가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th>주문번호</th>
			<th>구매자 회원번호(아이디로 바꾸기, 아이디 넣어주기)</th>
			<th>상품명</th>
			<th>총구매금액</th>
			<th>주문날짜</th>
			<th>배송상태</th>
		</tr>
		<c:forEach var="order" items="${list}">
		<tr>
			<td class="align-center">${order.order_num}</td>
			<td>${order.mem_num}</td>
			<td>
				<a href="admin_detail.do?order_num=${order.order_num}">${order.goods_name}</a>
			</td>
			<td><fmt:formatNumber value="${order.order_total}"/>원</td>
			<td>${order.order_regdate}</td>
			<td>
				<c:if test="${order.order_status == 1}">배송대기</c:if>
				<c:if test="${order.order_status == 2}">배송준비중</c:if>
				<c:if test="${order.order_status == 3}">배송중</c:if>
				<c:if test="${order.order_status == 4}">배송완료</c:if>
				<c:if test="${order.order_status == 5}">주문취소</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>	
</div>
<!-- 주문목록 - 관리자 끝 -->










