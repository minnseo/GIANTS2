<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 상품목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/goods.css">
<style>
.horizontal-area img{ width:175px; height:175px;}
</style>
<div class="page-main">
	<div class="goods-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>찜하기목록</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	
	<c:if test="${count == 0}">
	<div>찜한 상품이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<div class="goods-space">
		<c:forEach var="goods" items="${list}">
		<div class="horizontal-area">
			<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${goods.goods_num}">
				<img src="${pageContext.request.contextPath}/goods/imageView.do?goods_num=${goods.goods_num}">
				<span>${goods.goods_name}</span>
			</a>
		</div>
		</c:forEach>
		<hr width="100%" size="1" noshade="noshade" class="float-clear">
	</div>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 상품목록 끝 -->