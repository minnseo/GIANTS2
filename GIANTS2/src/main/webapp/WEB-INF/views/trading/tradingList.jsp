<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 중고거래 게시판 목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KMS/trading.css">
<script type="text/javascript">
	$(function() {
		//검색 유효성 체크
		$('#search_form').submit(function() {
			if ($('#keyword').val().trim() == '') {
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<div class="trading-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>중고거래</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<c:if test="${!empty user}">
	<div class="align-right">
		<input type="button" value="게시글 작성" onclick="location.href='tradingWrite.do'" class="classic-btn">
	</div>
	</c:if>
	<form action="tradingList.do" id="search_form" method="get" class="d-flex" role="search">
		<ul class="search">
			<li>
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>작성자</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
					<option value="4" <c:if test="${param.keyfield == 4}">selected</c:if>>제목+내용</option>
				</select>
			</li>
			<li>
				<input type="search" name="keyword" id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="검색" class="red-btn middle2">
			</li>
		</ul>
		<div class="trading_right">
			<select id="order" name="order">
				<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신순</option>
				<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				<option value="3" <c:if test="${param.order == 3}">selected</c:if>>관심수</option>
				<option value="4" <c:if test="${param.order == 4}">selected</c:if>>판매중</option>
			</select>
			<script type="text/javascript">
				$(function(){
					$('#order').change(function(){ //정렬 시
						location.href='tradingList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&order=' + $('#order').val();
					});
				});
			</script>
		</div>
	</form>
	<c:if test="${count == 0}">
	<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
	<table class="striped-table">
		<tr>
			<th colspan="2">제목</th>
			<th>작성자</th>
			<th>가격</th>
			<th>판매 상태</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<c:forEach var="trading" items="${list}">
		<tr>
			<td class="list-photo">
				<a href="tradingDetail.do?trade_num=${trading.trade_num}">
				<img src="${pageContext.request.contextPath}/trading/imageView.do?trade_num=${trading.trade_num}" class="list-thumbnail">
				</a>
			</td>
			<td>			
				<a href="tradingDetail.do?trade_num=${trading.trade_num}">${trading.trade_title}</a>
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
			<td class="align-center">${trading.trade_date}</td>
			<td class="align-center">${trading.trade_hit}</td>
		</tr>
		</c:forEach>
	</table>
	<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 중고거래 게시판 목록 끝 --> 