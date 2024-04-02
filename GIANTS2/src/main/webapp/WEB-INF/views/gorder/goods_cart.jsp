<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LYJ/cart.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods_cart.js"></script>
<!-- all_total, list(g_order_detail) - 사이즈 포함 -->
<!-- 장바구니 시작 -->
<div class="page-main">
	<h2>장바구니</h2>
	<br>
	<hr size="1">
	<br>
	<c:if test="${empty list}">
	<div class="result-display">
		장바구니에 담은 상품이 없습니다!
		<br>
		<br>
		<br>
		<br>
	</div>
	<div class="align-center">
		<input type="button" value="상품 구경하러가기" onclick="location.href='${pageContext.request.contextPath}/goods/goodsList.do'">
	</div>
	
	</c:if>
	<c:if test="${!empty list}">
	<form id="cart_order" action="${pageContext.request.contextPath}/gorder/orderForm.do" method="post">
		<table class="basic-table">
			<tr>
				<th>
					<input type="checkbox" checked="checked" id="chk_all">
				</th>
				<th>사진</th>
				<th>상품정보</th>
				<th>판매가</th>
				<th>수량</th>
				<th>적립예정포인트</th>
				<th>합계</th>
			</tr>
			<c:forEach var="cart" items="${list}">
			<input type="hidden" id="mem_num" value="${cart.mem_num}">
			<input type="hidden" id="opt_num" value="${cart.opt_num}">
				<tr>
					<td class="align-center">
						<input type="checkbox" name="cart_numbers" checked="checked" class="choice-btn" value="${cart.cart_num}">
					</td>
					<td>
						<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${cart.goods_num}">
							<img src="${pageContext.request.contextPath}/goods/imageView.do?goods_num=${cart.goods_num}" width="80" height="80">
						</a>
					</td>
					<!-- 상품정보 (상품명 + 옵션있는 경우 tr추가해서 옵션 노출)-->
					<td>
							${cart.goodsVO.goods_name}
					</td>
					
					<td class="align-center">
						<span class="goods_dprice" data-dprice="${cart.goodsVO.goods_dprice}"><fmt:formatNumber value="${cart.goodsVO.goods_dprice}"/>원</span>
						<input type="hidden" name="goods_dprice">
					</td>
					
					<td class = "align-center">
						<c:if test="${cart.goodsVO.goods_status==2 or cart.goodsOptionVO.goods_stock < cart.order_quantity}">[판매중지]</c:if>
						<c:if test="${cart.goodsVO.goods_status==1 and cart.goodsOptionVO.goods_stock >= cart.order_quantity}">
							<input type="number" id="order_quantity" name="order_quantity" min="1" max="${cart.goodsOptionVO.goods_stock}" 
							autocomplete = "off" value = "${cart.order_quantity}">
							<br>
							<br>
							<input type = "button" value = "변경" class = "cart-modify" 
							data-cartnum = "${cart.cart_num}" data-goodsnum = "${cart.goods_num}">
						</c:if>
					</td>
					
					<td class = "align-center">
					<span class="order_point" value="${cart.order_point}">${cart.order_point}p</span>
						<input type="hidden" name="order_point"> 
					</td>
					
					<td class="align-center">
						<div class="sub-total" data-total="${cart.sub_total}">
						<fmt:formatNumber value="${cart.sub_total}"/>원
						<br>
						<input type="button" value="삭제" class="cart-del" data-cartnum="${cart.cart_num}"> <!-- 여러개의 삭제가 생기기 때문에 class로 명시, 하나의 삭제만 필요하면 id로 명시하면 된다 -->
						</div>
					</td>					
					<c:if test="${cart.goods_size!='옵션없음'}">
						<tr class="option-tr">
						    <td colspan="7" class="option-td">
						        <span class="option-icon">
						            <span class="arrow-content">⤷</span>
						        
						        <img src="${pageContext.request.contextPath}/images/btn_order_option.gif" alt="옵션" title="옵션">
						        사이즈 : ${cart.goods_size}
						        </span>
						    </td>
						</tr>

					</c:if>
				</tr>
			</c:forEach>
				<tr>
					<td colspan="6" class="align-right"><b>총구매금액</b></td>
					<td class="align-center"><span class="all-total" data-alltotal="${all_total}"><fmt:formatNumber value="${all_total}"/>원</span></td>
				</tr>
		</table>
		
		<div class = "align-center">
			<input type="button" value="쇼핑 계속하기" onclick="location.href='${pageContext.request.contextPath}/goods/goodsList.do'">
			<input type = "submit" value = "주문하기"  id="order-btn">
			<input type="button" value="장바구니 비우기" class="deleteCartAll"> 
		</div>
	</form>
	</c:if>
</div>
<!-- 장바구니 끝 -->