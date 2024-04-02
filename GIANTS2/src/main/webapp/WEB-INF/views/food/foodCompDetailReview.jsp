<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 매장 상세보기 페이지 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/food.public.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodCompDetailMenu.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | <a href="/food/foodList.do">매장</a> | <a href="/food/foodCompDetailMenu.do?comp_num=${comp.comp_num}">${comp.comp_name}</a></h2>
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
		<form id="foodList_sort" action="foodList.do" method="get">
			<input type="hidden" name=comp_cate id="comp_cate" value="${comp.comp_cate}">
		</form>
		<!-- 관리자 접속시 수정 버튼 생성 -->
		<c:if test="${!empty user.mem_auth && user.mem_auth > 2}">
			<div class="float-right">
				<input type="button" class="adminBtn" value="수정하기" onclick='location.href="/food/fixCompFoodList.do?comp_num=${comp.comp_num}"'>
			</div>
		</c:if>
	</div>
	<div class="clear"></div>
	<!-- 매장 상세정보 시작 -->
	<div class=comp-container>
		<input type="hidden" name="comp_num" value="${comp.comp_num}" id="showComp">
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
		<!-- 메뉴보기, 리뷰보기 -->	
		<div class="comp-menu">
			<div id="showMenu">메뉴 보기</div>
			<div id="showReview" class="food-cbox-on">리뷰 보기</div>
		</div>
		<!-- 메뉴보기, 리뷰보기 내용-->
		<div id="compReview_content">
			<c:if test="${count == 0}">
				<h1 class="align-center">표시할 리뷰가 없습니다.</h1>
			</c:if>
			<c:if test="${count > 0}">
				<div class="compReview-container">
					<table id="review_List">
						<tr>
							<th>별점</th>
							<th>제목</th>
							<th>작성일</th>
						</tr>
						<c:forEach var="review" items="${list}">
						<tr>
							<td><b>${review.comp_score}</b> 점</td>
							<td><a href="${pageContext.request.contextPath}/food/foodReviewDetail.do?review_num=${review.review_num}"><b>${review.review_title}</b></a></td>
							<td>${review.review_regdate}</td>
						</tr>
						</c:forEach>
					</table>
				</div>
				<div class="paging align-center">${page}</div>
			</c:if>
		</div>
		<!-- 메뉴보기, 리뷰보기 내용 끝-->
	</div>
	<!-- 목록 끝 -->
</div>
<!-- 매장 상세보기 페이지 끝-->