<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 주문목록 - 사용자 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<!-- count, list, page -->
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>굿즈주문목록</h2>
		<p>자이언츠 굿즈주문목록 입니다.</p>
	</div>
</div>
<div class="mypage-form">
	<!-- action으로 인해 유효성 검사를 해도 폼이 제출되므로 onsubmit이 true일때만 처리되도록 -->
	<form action="orderList.do" id="search_form" method="get" onsubmit="return searchCheck()">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>주문번호</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>상품명</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기" class="default-btn">
				<input type="button" value="목록" class="default-btn"
				   onclick="location.href='orderList.do'">
			</li>
		</ul>
	</form>
	<script>
	function searchCheck(){   
		var selectedValue = document.querySelector("select[name='keyfield']").value;
    	var keywordValue = document.getElementById("keyword").value;
    	//주문번호 입력 시 숫자만 입력 가능
    	if(selectedValue==1 && isNaN(keywordValue)){
    		alert('숫자를 입력하세요!');
    		$('#keyword').val('').focus();
    		return false;
    	}
    	
    	if($('#keyword').val().trim()==''){
    		alert('검색어를 입력하세요');
    		$('#keyword').val('').focus();
    		return false;
    	}
    	return true;
	}
		//대표 상품명으로만 검색됨
	</script>
	
	
	
	<c:if test="${count == 0}">
		<div class="member-mypage align-center">구매내역이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<p class="Mypage-p">*주문번호 클릭시 상세페이지로 이동</p>
	<table class="striped-table">
		<tr>
			<th>주문번호</th>
			<th>상품명</th>
			<th>총구매금액</th>
			<th>주문날짜</th>
			<th>배송상태</th>
		</tr>
		<c:forEach var="order" items="${list}">
		<tr>
			<td class="align-center">
				<a href="orderDetail.do?order_num=${order.order_num}">${order.order_num}</a>
			</td>
			<td>
				${order.goods_name}
			</td>
			<td class="align-center"><fmt:formatNumber value="${order.order_total}"/>원</td>
			<td class="align-center">${order.order_regdate}</td>
			<td class="align-center">
				<c:if test="${order.order_status == 0}">결제완료</c:if>
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
<!-- 주문목록 - 사용자 끝 -->










