<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 매장 수정 페이지 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodCss.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/fixCompFoodList.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | <a href="/food/foodList.do">매장</a> | <a href="/food/foodCompDetail.do?comp_num=${comp.comp_num}">${comp.comp_name}</a></h2>
	</div>
	<hr noshade="noshade">
	<!-- 카테고리 시작 -->
	<div class="food-category">
		<!-- 우측 수정, 취소 버튼 -->
		<div class="float-right">
			<input type="submit" class="adminBtn" value="수정" onclick="location.href='${pageContext.request.contextPath}/member/myPage.do'">
			<input type="button" class="adminBtn" value="뒤로가기" onclick='location.href="/food/foodCompDetailMenu.do?comp_num=${comp.comp_num}"'>
		</div>
	</div>
	<div class="clear"></div>
	<!-- 매장 상세정보 시작 -->
	<div class=comp-container>
		<div class="comp-detail"><!-- 상세페이지 링크는 스크립트로 해결해야함. -->
			<div class="f-img">
				<c:if test="${empty comp.comp_photoname || comp.comp_photoname == ''}">
					<img src="${pageContext.request.contextPath}/images/product-ready.png" class="food-main-img">
				</c:if> 
				<c:if test="${!empty comp.comp_photoname}">
					<img src="${pageContext.request.contextPath}/food/compImageView.do?comp_num=${comp.comp_num}" class="food-main-img">
				</c:if> 
			</div>
			<div class="comp-title"><b>${comp.comp_name}</b></div>
			<div class="comp-score"><b>별점 - ${comp.comp_score}</b></div>
			<div class="comp-content">
				${comp.comp_content}
			</div>
		</div>
		<!-- 새 상품 추가하기 시작 -->	
		<div class="compFood-list">
			<a href="${pageContext.request.contextPath}/food/addNewFood.do">
				<img src="${pageContext.request.contextPath}/images/plus.png">
				<span>새 상품 추가하기</span>
			</a>
		</div>
		<!-- 새 상품 추가하기 끝-->
		<!-- 기업 상품 리스트 시작 -->
		<div id="fix_compMenu">
			<c:if test="${count == 0}"><!-- 목록 없을 경우 -->
				<table id="fix_menuList">
					<tr>
						<th> 표시할 상품이 없습니다. </th>
					</tr>
				</table>
			</c:if>
			
			<c:if test="${count > 0}"> <!-- 목록 있을 경우 -->
				<table id="fix_menuList">
					<tr>
						<th>상품번호</th>
						<th>상품명</th>
						<th>가격</th>
						<th>재고수량</th>
						<th>상태</th>
						<th>수정/삭제</th>
					</tr>
					<c:forEach var="food" items="${list}">
					<tr>
						<td>${food.food_num}</td>
						<td>${food.food_name}</td>
						<td><fmt:formatNumber value="${food.food_price}"/> 원</td>
						<td><fmt:formatNumber value="${food.food_quantity}"/> 개</td>
						<td>
							<c:if test="${food.food_status == 1 }">판매중지</c:if>
							<c:if test="${food.food_status == 2 }">판매중</c:if>
						</td>
						<td>
							<input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath}/food/fixFood.do?food_num=${food.food_num}'"> 
							<form id="del_form_${food.food_num}" action="deleteFood.do" method="post">
								<input type="hidden" name="food_num" value="${food.food_num}">
								<input type="button" value="삭제" class="del-food" data-num="${food.food_num}">
							</form>
						</td>
					</tr>
					</c:forEach>
				</table>
				<div class="paging align-center">${page}</div>
			</c:if>
		</div>
		<!-- 기업 상품 리스트 끝 -->
	</div>
	<!-- 목록 끝 -->
</div>
<!-- 매장 상세보기 페이지 끝-->