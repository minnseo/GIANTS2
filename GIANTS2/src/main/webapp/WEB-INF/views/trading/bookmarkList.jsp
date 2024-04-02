<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KMS/trading.css">
<!-- 복마크 목록 시작 -->
<div class="bookmark-top">
	<div class="bookmark-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>중고거래 관심목록</h2>
	</div>
</div>
<div class="bookmark-form">
		<br><br>
		<c:if test="${count == 0}">
		<div class="result-display">표시할 관심목록이 없습니다.</div>
		</c:if>
		<c:if test="${count > 0}">
			<table class="striped-table">
				<tr>
					<th colspan="2">제목</th>
					<th>작성자</th>
					<th>가격</th>
					<th>판매 상태</th>
				</tr>
				<c:forEach var="trading" items="${list}">
				<tr>
					<td class="list-photo">
						<a href="${pageContext.request.contextPath}/trading/tradingDetail.do?trade_num=${trading.trade_num}">
						<img src="${pageContext.request.contextPath}/trading/imageView.do?trade_num=${trading.trade_num}" class="list-thumbnail">
						</a>
					</td>
					<td>			
						<a href="${pageContext.request.contextPath}/trading/tradingDetail.do?trade_num=${trading.trade_num}">${trading.trade_title}</a>
					</td>
					<td class="align-center">
						<c:if test="${empty trading.mem_nickname}">${trading.mem_id}</c:if>
						<c:if test="${!empty trading.mem_nickname}">${trading.mem_nickname}</c:if>
					</td>
					<td class="align-center">${trading.trade_price}원</td>
					<td class="align-center">
						<c:if test="${trading.trade_status == 0}">판매중</c:if>
						<c:if test="${trading.trade_status == 1}">거래 완료</c:if>
					</td>
				</tr>
				</c:forEach>
			</table>
		<br><br>
		<div class="align-center">${page}</div>
		</c:if>
</div>
<!-- 복마크 목록 끝 -->