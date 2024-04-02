<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 매장 수정 페이지 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>푸드목록</h2>
		<p>자이언츠 (기업)${company.companyDetailVO.comp_name} 푸드목록 입니다.</p>
	</div> 
</div>
<div class="mypage-form">
		<!-- 기업 상품 리스트 시작 -->
		<div id="fix_compMenu"> 
			<c:if test="${count == 0}">
				<div class="member-mypage align-center"> 표시할 상품이 없습니다.</div>
			</c:if>
			<c:if test="${count > 0}"> <!-- 목록 있을 경우 -->
				<p class="Mypage-p">*상품번호 클릭시 상세페이지로 이동</p>
				<div class="float-right">
            		<input type="button" class="foodModify-btn" value="수정하기" onclick='location.href="/food/fixCompFoodList.do?comp_num=${comp.comp_num}"'>
        		 </div>
				<table class="striped-table">
					<tr>
						<th>상품번호</th>
						<th>상품명</th>
						<th>가격</th>
						<th>재고수량</th>
						<th>상태</th>
					</tr>
					<c:forEach var="food" items="${list}">
					<tr>
						<td class="align-center">
							<form class="align-center" id="del_form_${food.food_num}" action="deleteFood.do" method="post">
							<a href="${pageContext.request.contextPath}/food/fixFood.do?food_num=${food.food_num}">${food.food_num}</a>
				            </form>
					 	</td>
						<td>${food.food_name}</td>
						<td class="align-center"><fmt:formatNumber value="${food.food_price}"/> 원</td>
						<td class="align-center"><fmt:formatNumber value="${food.food_quantity}"/> 개</td>
						<td class="align-center">
							<c:if test="${food.food_status == 1 }">판매중지</c:if>
							<c:if test="${food.food_status == 2 }">판매중</c:if>
						</td>
					</tr>
					</c:forEach>
				</table>
				<div class="paging align-center">${page}</div>
			</c:if>
		</div>
		<!-- 기업 상품 리스트 끝 -->
	</div>
