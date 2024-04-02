<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- (푸드)리뷰 상세 페이지 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/OSJ/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/food.public.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/foodJS/foodReviewDetail.js"></script>
<div class="page-main">
	<div class="main-title">
		<img class="title-img" src="${pageContext.request.contextPath}/images/title_icon.gif">
		<h2> 푸드 | <a href="/food/foodList.do">매장</a> | <a href="/food/foodCompDetailMenu.do?comp_num=${comp.comp_num}">${comp.comp_name}</a> | 리뷰상세보기</h2>
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
		<c:if test="${!empty user.mem_auth && user.mem_auth == 2 && review.mem_num == user.mem_num || user.mem_auth == 9}">
			<div class="float-right">
			</div>
		</c:if>
	</div>
	<div class="clear"></div>
	<!--  시작 -->
	<div class=comp-container>
		<div class="review-detail">
			<div class="review-top">
				<ul>
					<li>
						<h1>제목 : ${review.review_title}</h1>
					</li>
					<li>
						<h4 class="bd-right">별점 : ${review.comp_score}</h4> <h4>작성일 : ${review.review_regdate}</h4>
					</li>
				</ul>
				<div class="clear"></div>
			</div>
			<hr>
			<div class="review-content">
				${review.review_content}
			</div>
			<div class="review-buttons align-center">
				<c:if test="${review.mem_num == user.mem_num || user.mem_auth == 9 }">
					<input type="button" value="삭제하기" id="delete_review">
					<input type="hidden" value="${review.review_num}" id="review_num">
					<input type="hidden" value="${comp.comp_num}" id="comp_num">
				</c:if>
				<input type="button" value="리뷰목록으로" onclick="location.href='${pageContext.request.contextPath}/food/foodCompDetailReview.do?comp_num=${comp.comp_num}'">
			</div>
		</div>
		<!-- 메뉴보기 내용 끝-->
	</div>
	<!-- 목록 끝 -->
</div>
<!-- (푸드)리뷰 상세 페이지 끝-->