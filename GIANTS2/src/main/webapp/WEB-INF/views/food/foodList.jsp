<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 매장리스트 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/food.public.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodList.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | <a href="/food/foodList.do">매장</a></h2>
	</div>
	<hr noshade="noshade">
	<!-- 카테고리 시작 -->
	<div class="food-category">
		<ul class="float-left">
			<li><div class="food-cbox" data-comp_cate="1">치 킨</div></li><!--
		--><li><div class="food-cbox" data-comp_cate="2">술/안주</div></li><!--
		--><li><div class="food-cbox" data-comp_cate="3">분 식</div></li><!--
		--><li><div class="food-cbox" data-comp_cate="4">간 식</div></li><!--
		--><li><div class="food-cbox" data-comp_cate="5">패스트푸드</div></li>
		</ul>
		<div class="float-right">
		<form id="foodList_sort" action="foodList.do" method="get">
			<input type="hidden" name=comp_cate id="comp_cate" value="${comp_cate}">
			<select id="sort_select" name="sort">
				<option value="1" <c:if test="${sort == 1}">selected</c:if>>별점 높은순</option>
				<option value="2" <c:if test="${sort == 2}">selected</c:if>>별점 낮은순</option>
			</select>
		</form>
		</div>
	</div>
	<div class="clear"></div>
	<!-- 목록 시작 -->
	<!-- 카테고리별 목록 표시 필터 구현-->
	<c:if test="${count == 0}">
		<div class="food-list">
			<div class="f-list"><!-- 상세페이지 링크는 스크립트로 해결해야함. -->
				<div class="align-center">
					<h1>표시할 매장이 없습니다.</h1>
				</div>
			</div>
		</div>
	</c:if>
	<c:if test="${count > 0}">
		<div class="food-list">
			<c:forEach var="comp" items="${list}">
				<div class="f-list"><!-- 상세페이지 링크는 스크립트로 해결해야함. -->
					<form action="foodCompDetailMenu.do" method="get">
						<input type="hidden" name=comp_num value="${comp.comp_num}" >
					</form>
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
			</c:forEach>
		</div>
	</c:if>
	<!-- 목록 끝 -->
	<div class="paging align-center">${page}</div>
</div>
<!-- 매장리스트 끝-->