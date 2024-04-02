<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<!-- 상품목록 시작 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods.filter.js"></script>
<script type="text/javascript"> 
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim() == ''){
				alert('검색어를 입력하세요.');
				$('#keyword').val('').focus();
				return false;
			}
		});
		
		$('#filter_all').click(function(){
			console.log($('#filter_all').val());
			location.href='adminMypageGoodsList.do';
		});
		
		$('#filter_uniform').click(function(){
			console.log($('#filter_uniform').val());
			location.href='adminMypageGoodsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&goods_category=' + $('#filter_uniform').val();
		}); 
		
		$('#filter_cap').click(function(){
			console.log($('#filter_cap').val());
			location.href='adminMypageGoodsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&goods_category=' + $('#filter_cap').val();
		}); 
		
		$('#filter_cheering').click(function(){
			console.log($('#filter_cheering').val());
			location.href='adminMypageGoodsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&goods_category=' + $('#filter_cheering').val();
		}); 
		
		$('#filter_etc').click(function(){
			console.log($('#filter_etc').val());
			location.href='adminMypageGoodsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&goods_category=' + $('#filter_etc').val();
		});
	});
</script>
<style>
.horizontal-area img{ width:175px; height:175px;}
</style>
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>굿즈목록</h2>
		<p>자이언츠 굿즈목록 입니다.</p>
	</div>
</div> 
<div class="mypage-form">
	<form action="adminMypageGoodsList.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>상품명</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기" class="bottom-btn">
				<input type="button" value="목록" class="bottom-btn"
					   onclick="location.href='adminMypageGoodsList.do'">
			</li>
		</ul>
	</form>
	<c:if test="${count == 0}">
		<div>표시할 상품이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<%-- <p class="mypage-r">
		<input type="button" value="상품등록" class="defa"
		       onclick="location.href='${pageContext.request.contextPath}/goods/registerGoods.do'">
		</p> --%>
		<p class="Mypage-p">*상품번호 클릭시 상세페이지로 이동</p>
		<table class="striped-table">
			<tr>
				<th>번호</th>
				<th>카테고리</th>
				<th>상품명</th>
				<th>판매가</th>
				<th>등록일</th>
				<th>상태</th>
				<th>수정</th>
			</tr>
			<c:forEach var="goods" items="${list}">
			<tr>
				<td class="align-center">
					<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${goods.goods_num}">${goods.goods_num}</a>
				</td>
				<td class="align-center">
					<c:if test="${goods.goods_category == 1}">유니폼</c:if>
					<c:if test="${goods.goods_category == 2}">모자</c:if>
					<c:if test="${goods.goods_category == 3}">응원도구</c:if>
					<c:if test="${goods.goods_category == 4}">기타</c:if>
				</td>
				<td class="align-center">
					${goods.goods_name}
				</td>
				<td class="align-center">
					<fmt:formatNumber value="${goods.goods_dprice}"/>원
				</td>
				<td>${goods.goods_regdate}</td>
				<td>
					<c:if test="${goods.goods_status == 1}">판매중</c:if>
					<c:if test="${goods.goods_status == 2}"><b style="color:#dd032f;">판매중지</b></c:if>
				</td>	
				<td class="align-center">
					<input class="table-td-btn" type="button" value="수정" onclick="location.href='${pageContext.request.contextPath}/goods/goodsUpdate.do?goods_num=${goods.goods_num}'">
				</td>
			</tr>
			</c:forEach>
		</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 상품목록 끝 -->