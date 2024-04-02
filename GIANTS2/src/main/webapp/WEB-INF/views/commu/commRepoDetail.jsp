<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
li{
	float:left;
}
.result-display{
	width:400px;
	height:200px;
	margin:50px auto;
	border:1px solid #000;
	display:flex;
	align-items:center;
	justify-content:center;
}


.title01{
	display:flex;
}



</style>
<!-- [관리자]신고 목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LHJ/commu.css">
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim() == ''){
				alert('검색어를 입력하세요!');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<div class="page-main">
	<div class="main-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<div class="title01">
			<h2 style="margin-right:5%">신고목록</h2>
			<p>자이언츠의 [관리자] 신고목록 공간입니다.</p>
		</div>
	</div>
	<hr size="0.05" width="100%" noshade style="margin-bottom:3%">
	
	
	
		
	
	<!-- 목록 -->
	<c:if test="${count == 0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<table class="striped-table">
			<tr>
				<th>신고번호</th>
				<th>신고자</th>
				<th>신고날짜</th>
				<th>신고내용</th>
				<th>카테고리</th>
			</tr> 
			<c:forEach var="commuRepo" items="${list}">
				<tr>
					<td class="align-center">${commuRepo.repo_num}</td>
					<td class="align-center">
						<c:if test="${empty commuRepo.mem_nickname}">${commuRepo.mem_id}</c:if>
						<c:if test="${!empty commuRepo.mem_nickname}">${commuRepo.mem_nickname}</c:if>
					</td>
					<td class="align-center">${commuRepo.repo_date}</td>
					<td class="align-center">${commuRepo.repo_content}</td>
					<td class="align-center">${commuRepo.repo_category}</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 페이지 -->
		<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 커뮤니티 목록 끝 -->