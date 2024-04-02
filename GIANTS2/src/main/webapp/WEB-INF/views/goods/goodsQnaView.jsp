<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 굿즈 상품문의 상세 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/goods.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/goods.qna-answer.js"></script>
<div class="page-main">
	<div class="goods-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>상품문의</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<table class="top-part">
		<tr>
			<th colspan="1">제목</th>
			<td colspan="6">${qna.qna_title}</td>
		</tr>
		<tr>
			<th>상품명</th>
			<td>
				<a href="goodsDetail.do?goods_num=${qna.goods_num}">${qna.goods_name}</a>
			</td>
			<th>작성자</th>
			<td>${qna.mem_id}</td>
			<th>작성일</th>
			<td>${qna.qna_regdate}</td>
			<td>
				<c:if test="${qna.qna_status == 1}">
					<input type="checkbox" disabled>처리전
				</c:if>
				<c:if test="${qna.qna_status == 2}">
					<input type="checkbox" checked="checked" disabled><b>답변완료</b>
				</c:if>
			</td>
		</tr>
	</table>
	<hr size="1" width="100%">
	<div class="detail-content">
		${qna.qna_content}
	</div>
	<div class="align-right" style="margin-bottom:10px;">
		<c:if test="${!empty user && user.mem_num == qna.mem_num}">
			<input type="button" value="수정" onclick="location.href='updateGoodsQna.do?qna_num=${qna.qna_num}'">
			<input type="button" value="삭제" id="delete_btn">
			<script type="text/javascript">
				let delete_btn = document.getElementById('delete_btn');
				
				delete_btn.onclick = function(){
					let choice = confirm('삭제하시겠습니까?');
					if(choice){
						location.replace('deleteGoodsQna.do?qna_num=${qna.qna_num}');
					}
				};
			</script>
		</c:if>
		<input type="button" value="상품상세" onclick="location.href='goodsDetail.do?goods_num=${qna.goods_num}#goods_qna'">
	</div>
	<hr size="1" width="100%">
	<%-- 답변 시작 --%>
	<div id="answer_div">
		<!-- <span>답변</span> -->
		<form id="gans_form">
			<input type="hidden" name="qna_num" value="${qna.qna_num}" id="qna_num">
			<textarea rows="3" cols="50" name="gans_content" id="gans_content" class="align-left rep-content"
				<c:if test="${empty user || user.mem_auth != 9}">disabled="disabled"</c:if>
				><c:if test="${empty user || user.mem_auth != 9}">관리자만 작성할 수 있습니다.</c:if></textarea>
			<c:if test="${!empty user && user.mem_auth == 9}">
			
			<div id="ans_first" class="align-left">
				<span class="letter-count">300/300</span>
			</div>
			<div id="ans_second" class="align-right">
				<input type="submit" value="등록">
			</div>
			</c:if>
		</form>
	</div>
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="더보기">
	</div>
	<div class="loading" style="display:none;">
		<img src="${pageContext.request.contextPath}/images/loading.gif" width="100" height="100">
	</div>
	<%-- 답변 끝 --%>
</div>
<!-- 굿즈 상품문의 상세 끝 -->