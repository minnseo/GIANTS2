<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- 상품목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/goods.css">
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
	});
</script>
<style>
.horizontal-area img{ width:175px; height:175px;}
</style>
<div class="page-main">
	<div class="goods-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>상품목록</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	
	<form action="goodsList.do" id="search_form" method="get">
		<ul class="filter-btns">
			<li>
				<div class="align-right" id="list-btns">
				<c:if test="${!empty user && user.mem_auth == 9}">
					<input type="button" value="상품등록" onclick="location.href='registerGoods.do'">
					<input type="button" value="[관리자]목록" onclick="location.href='${pageContext.request.contextPath}/member/adminMypageGoodsList.do'" id="admin_btn">
					<input type="button" value="[관리자]매출" onclick="location.href='${pageContext.request.contextPath}/gorder/adminMypageSaleManage.do'" id="admin_btn">
				</c:if>
					<input type="button" value="전체목록" onclick="location.href='goodsList.do'">
				</div>
				<div id="cate-filter">
					<button name="goods_category" type="button" value="0" id="filter_all"
						<c:if test="${empty param.goods_category || param.goods_category == 0}"> class="on" </c:if>
						<c:if test="${param.goods_category != 0}"> class="off" </c:if>>전체</button>
					<button name="goods_category" type="button" value="1" id="filter_uniform" 
						<c:if test="${param.goods_category == 1}"> class="on" </c:if>
						<c:if test="${param.goods_category != 1}"> class="off" </c:if>>유니폼</button>
					<button name="goods_category" type="button" value="2" id="filter_cap" 
						<c:if test="${param.goods_category == 2}"> class="on" </c:if>
						<c:if test="${param.goods_category != 2}"> class="off" </c:if>>모자</button>
					<button name="goods_category" type="button" value="3" id="filter_cheering"
						<c:if test="${param.goods_category == 3}"> class="on" </c:if>
						<c:if test="${param.goods_category != 3}"> class="off" </c:if>>응원도구</button>
					<button name="goods_category" type="button" value="4" id="filter_etc"
						<c:if test="${param.goods_category == 4}"> class="on" </c:if>
						<c:if test="${param.goods_category != 4}"> class="off" </c:if>>기타</button>
				</div>
				<hr size="0.05" width="100%" noshade>
			</li>
		</ul>
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>상품명 + 내용</option>
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>상품명</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="검색" style="height:30px;">
			</li>
		</ul>
		<div class="align-left">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>찜하기순</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>리뷰많은순</option>
				<option value="4" <c:if test="${param.order == 4}">selected</c:if>>할인율높은순</option>
				<option value="5" <c:if test="${param.order == 5}">selected</c:if>>낮은가격순</option>
			</select>
			<script type="text/javascript">
				$(function(){
					
					$('#order').change(function(){
						location.href='goodsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&order=' + $('#order').val() + '&goods_category=' + $('button[name="goods_category"]').val();
					});
					
					/* $('button[name="goods_category"]').click(function{
						location.href='goodsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&order=' + $('#order').val() + '&goods_category=' + $('button[name="goods_category"]').val();
					});*/
					
					$('#filter_all').click(function(){
						location.href='goodsList.do';
					});
					
					$('#filter_uniform').click(function(){
						//$('#order').val(1);
						location.href='goodsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&order=' + $('#order').val() + '&goods_category=' + $('#filter_uniform').val();
					}); 
					
					$('#filter_cap').click(function(){
						//$('#order').val(1);
						location.href='goodsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&order=' + $('#order').val() + '&goods_category=' + $('#filter_cap').val();
					}); 
					
					$('#filter_cheering').click(function(){
						console.log($('#filter_cheering').val());
						location.href='goodsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&order=' + $('#order').val() + '&goods_category=' + $('#filter_cheering').val();
					}); 
					
					$('#filter_etc').click(function(){
						console.log($('#filter_etc').val());
						location.href='goodsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&order=' + $('#order').val() + '&goods_category=' + $('#filter_etc').val();
					});
										
				});
			</script>
		</div>
	</form>
	<c:if test="${count == 0}">
	<div>표시할 상품이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<div class="goods-space">
		<c:forEach var="goods" items="${list}">
		<div class="horizontal-area">
			<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${goods.goods_num}">
				<img src="${pageContext.request.contextPath}/goods/imageView.do?goods_num=${goods.goods_num}">
				<span>${goods.goods_name}</span>
				<br>
				<c:if test="${goods.total_stock > 0}">
				<b><fmt:formatNumber value="${goods.goods_dprice}"/>원</b>
				</c:if>
				<%-- 품절 표시 --%>
				<c:if test="${goods.total_stock <= 0}">
				<b style="background-color:red; color:#FFF;">SOLD OUT</b>
				</c:if>
			</a>
		</div>
		</c:forEach>
		<hr width="100%" size="1" noshade="noshade" class="float-clear">
	</div>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 상품목록 끝 -->