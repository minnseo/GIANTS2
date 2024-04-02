<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
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
		<h2>주문내역</h2>
		<p>자이언츠 (기업) 주문내역 입니다.</p>
	</div> 
</div>
<!-- 주문목록 - 관리자 시작 -->
<div class="mypage-form">
	<form action="compMypageOrderList.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>주문번호</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>상품명</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>구매자</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword"
				                     value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기" class="default-btn">
				<input type="button" value="목록" class="default-btn"
				   onclick="location.href='compMypageOrderList.do'">
			</li>
		</ul>      
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 주문정보가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<p class="Mypage-p">*주분번호 클릭시 상세페이지로 이동</p>
	<table class="striped-table"> 
		<tr>
			<th>주문번호</th>
			<th>상품명</th>
			<th>구매자</th>
			<th>결제금액</th>
			<th>주문날짜</th>
			<th>QR사용상태</th>
		</tr>
		<c:forEach var="order" items="${list}">
		<tr>
			<td class="align-center">
				<a href="${pageContext.request.contextPath}/member/compMypageOrderDetail.do?f_order_num=${order.f_order_num}">${order.f_order_num}</a></td>
			<td>
				${order.f_order_name}
			</td>
			<td class="align-center">${order.buyer_name}</td>
			<td class="align-center">${order.total_price}</td>
			<td class="align-center">${order.f_order_regDate}</td>
			<td class="align-center">	
				<c:if test="${order.f_order_status == 0}">QR사용완료</c:if>
				<c:if test="${order.f_order_status == 1}">QR사용전</c:if>
				<c:if test="${order.f_order_status == 9}">주문취소</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>	
</div>
<!-- 주문목록 - 관리자 끝 -->