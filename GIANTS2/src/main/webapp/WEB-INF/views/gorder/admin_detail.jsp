<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<!-- 주문내역 시작 -->
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>굿즈주문상세</h2>
		<p>자이언츠 굿즈주문상세 입니다.</p>
	</div>
</div>
<div class="mypage-form">
	    <table class="striped-table">
	    	<tr>
	    		<th>상품명</th>
	    		<th>수량</th>
	    		<th>가격</th>
	    		<th>배송비</th>
	    		<th>합계</th>
	    	</tr>
	    	<c:forEach var="detail" items="${detailList}">
	    	<tr>
	    		<td>${detail.goods_name}</td>
	    		<td class="align-center"><fmt:formatNumber value="${detail.order_quantity}"/></td>
	    		<td class="align-center"><fmt:formatNumber value="${detail.goods_dprice}"/>원</td>
	    		<td class="align-center"><fmt:formatNumber value="${detail.order_dcost}"/>원</td>
	    		<td class="align-center"><fmt:formatNumber value="${detail.order_total}"/>원</td>
	    	</tr>	
	    	</c:forEach>
	    	<tr>
	    		<td colspan="4" class="align-right"><b>총구매금액</b></td>
	    		<td class="align-center">
	    			<fmt:formatNumber value="${orderVO.order_total}"/>
	    		</td>
	    	</tr>
	    </table>         
		<ul>
			<li>
				<span>받는 사람 :
				${orderVO.order_name}
				</span>
			</li>
			<li>
				<span>우편번호 :
				${orderVO.order_post}
				</span>
			</li>
			<li>
				<span>주소 : 
				${orderVO.order_address1} ${orderVO.order_address2}
				</span>
			</li>
			<li>
				<span>전화번호 : 
				${orderVO.mem_phone}
				</span>
			</li>
			<li>
				<span>남기실 말씀 : 
				${orderVO.order_message}
				</span>
			</li>
			<li>
				<span>결제수단 : 
				<c:if test="${orderVO.order_payment == 1}">은행입금</c:if>
				<c:if test="${orderVO.order_payment == 2}">카드결제</c:if>
				</span>
			</li>
			<li>
				<span>배송상태 : 
				<c:if test="${orderVO.order_status == 1}">배송대기</c:if>
				<c:if test="${orderVO.order_status == 2}">배송준비중</c:if>
				<c:if test="${orderVO.order_status == 3}">배송중</c:if>
				<c:if test="${orderVO.order_status == 4}">배송완료</c:if>
				<c:if test="${orderVO.order_status == 5}">주문취소</c:if>
				</span>
			</li>
		</ul>	
		<div class="align-center">
			<c:if test="${orderVO.order_status == 1}">
			<input type="button" value="배송지정보수정" 
			 onclick="location.href='admin_modify.do?order_num=${orderVO.order_num}'" class="default-btn">
			</c:if>
			<c:if test="${orderVO.order_status != 5}">
			<input type="button" value="배송상태수정" onclick="location.href='admin_status.do?order_num=${orderVO.order_num}'" class="default-btn">
			</c:if>
			<input type="button" value="주문목록" class="default-btn"
			 onclick="location.href='${pageContext.request.contextPath}/order/admin_list.do'">
			<input type="button" value="MyPage" class="default-btn"
			 onclick="location.href='${pageContext.request.contextPath}/member/myPage.do'">
		</div>             
</div>
<!-- 주문내역 끝 -->



