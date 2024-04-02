<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!-- 주문내역 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<style>
#order-list-value{
	font-size: 17px;
	/* font-weight: bold; */
}

.ul-container {
    display: flex;
    flex-direction: row;
}

#ul-one, #ul-two {
    flex: 1;
    padding: 0; 
    margin: 0 5px; /* 리스트 간격 조절 */
}
</style>
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>굿즈주문내역</h2>
		<p>자이언츠 굿즈주문내역 입니다.</p>
	</div>
</div>
<div class="mypage-form">
	    <table class="striped-table">
	    	<tr>
	    		<th>사진</th>
	    		<th>상품정보</th>
	    		<th>수량</th>
	    		<th>가격</th>
	    		<th>합계</th>
	    	</tr>
	    	<c:forEach var="detail" items="${detailList}">
	    	<tr>
	    		<td class="align-center">
					<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${detail.goods_num}">
						<img src="${pageContext.request.contextPath}/goods/imageView.do?goods_num=${detail.goods_num}" width="80" height="80">
		    		</a>
	    		</td>
	    		<td class="align-center">
		    		<a href="${pageContext.request.contextPath}/goods/goodsDetail.do?goods_num=${detail.goods_num}">
			    		<span id="detail_goods_name">${detail.goods_name} (${detail.goods_size})</span>
			    	</a>
	    		</td>
	    		<td class="align-center"><fmt:formatNumber value="${detail.order_quantity}"/></td>
	    		<td class="align-center"><fmt:formatNumber value="${detail.goods_dprice}"/>원</td>
	    		<td class="align-center"><fmt:formatNumber value="${detail.goods_total}"/>원</td> <!-- 동일 상품 -->
	    	</tr>	
	    	 </c:forEach>
	    	<tr>
	    		<td colspan="4" class="align-right"><b>총구매금액</b></td>
	    		<td class="align-center">
	    			<fmt:formatNumber value="${all_total}"/>원
	    		</td>
	    	</tr>
	    	
	    	<tr>
	    		<td colspan="4" class="align-right"><b>사용한 포인트</b></td>
	    		<td class="align-center">
	    			${orderVO.used_point}p
	    		</td>
	    	</tr>
	    	
	    	
	    	<tr>
	    		<td colspan="4" class="align-right"><b>최종 결제금액</b></td>
	    		<td class="align-center">
	    			<fmt:formatNumber value="${orderVO.order_total}"/>원
	    		</td>
	    	</tr>
	    </table>        
	   <br>
		</div>
<div class="member-mypage">
	<table class="mem-table">
		<tr>
			<td>결제자 </td><td>${orderVO.receive_name}</td>
		</tr>
		<tr>
			<td>받는사람 </td><td>${orderVO.order_name}</td>
		</tr>
		<tr>
			<td>우편번호 </td><td>${orderVO.order_zipcode}</td>
		</tr>
		<tr>
			<td>주소 </td><td>${orderVO.order_address1} ${orderVO.order_address2}</td>
		</tr>
		<tr>
			<td>전화번호 </td><td>${orderVO.mem_phone}</td>
		</tr>
		<tr>
			<td>남기실말씀 </td><td>${orderVO.order_message}</td>
		</tr>
		<tr>
			<td>결제수단 </td>
			<td>
				<c:if test="${orderVO.order_payment == 1}">카드결제</c:if>
				<c:if test="${orderVO.order_payment == 2}">은행입금</c:if>
			</td>
		</tr>
		<tr>
			<td>배송상태 </td>
			<td>
				<c:if test="${orderVO.order_status == 0}">결제완료</c:if>
				<c:if test="${orderVO.order_status == 1}">배송대기</c:if>
				<c:if test="${orderVO.order_status == 2}">배송준비중</c:if>
				<c:if test="${orderVO.order_status == 3}">배송중</c:if>
				<c:if test="${orderVO.order_status == 4}">배송완료</c:if>
				<c:if test="${orderVO.order_status == 5}">주문취소</c:if></td>
			</tr>
	</table>
</div>
<div class="align-center">
			<c:if test="${orderVO.order_status == 1}">
			<input type="button" value="배송지정보수정" 
			 onclick="location.href='${pageContext.request.contextPath}/member/adminMypageGoodsOrderModify.do?order_num=${orderVO.order_num}'" class="default-btn">
			</c:if>
			<c:if test="${orderVO.order_status != 5}">
			<input type="button" value="배송상태수정" onclick="location.href='${pageContext.request.contextPath}/member/adminMypageGoodsOrderStatus.do?order_num=${orderVO.order_num}'" class="default-btn">
			</c:if>
			<input type="button" value="주문목록" class="default-btn"
			 onclick="location.href='${pageContext.request.contextPath}/member/adminMypageGoodsOrderList.do'">
			<input type="button" value="MyPage" class="default-btn"
			 onclick="location.href='${pageContext.request.contextPath}/member/myPage.do'">
		</div>   
<!-- 주문내역 끝 -->



