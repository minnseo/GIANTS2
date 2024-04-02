<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodCss.js"></script>
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>Foods</h2>
		<p>자이언츠 Food 구매내역 입니다.</p>
	</div>
</div> 
<!-- 주문목록 - 관리자 시작 -->
<div class="mypage-form">
	<form action="memberMypageFoodList.do" id="search_form" method="get">
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
		<div class="member-mypage align-center">구매내역이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<p class="Mypage-p">*주문번호 클릭시 상세페이지로 이동</p>
	<table class="striped-table">
		<tr>
			<th>주문번호</th> 
			<th>상품명</th>
			<th>구매자</th>
			<th>결제금액</th>
			<th>주문날짜</th>
			<th>주문취소</th>
		</tr>
		<c:forEach var="order" items="${list}">
		<tr>
			<td class="align-center">
				<a href="${pageContext.request.contextPath}/member/memberMypageFoodDetail.do?f_order_num=${order.f_order_num}">${order.f_order_num}</a>
			</td>
			<td>${order.f_order_name}</td>
			<td class="align-center">${order.buyer_name}</td>
			<td class="align-center">${order.total_price}</td>
			<td class="align-center">${order.f_order_regDate}</td>
			<td class="align-center">
				<c:if test="${order.f_order_status == 1}">
				<input type="button" value="주문취소" id="order_cancel" class="default-btn" data-order_num="${order.f_order_num}">
				<script>  
				$(function(){
					$(document).on('click','#order_cancel',function(){
						let choice = confirm('주문을 취소하시겠습니까?');
						if (choice) { 
							let order_num = $(this).attr('data-order_num');
							//console.log(order_num);
							location.replace('orderCancel.do?f_order_num='+order_num);
						}
					});
				});
					
				</script>
				</c:if>
				<c:if test="${order.f_order_status == 9}">
					취소완료
				</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>	
</div>
<!-- 주문목록 - 관리자 끝 -->