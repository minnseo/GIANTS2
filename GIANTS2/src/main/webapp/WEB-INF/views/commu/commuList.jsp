<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>

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
<!-- 커뮤니티 목록 시작 -->
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
			<h2 style="margin-right:5%"><a href="commuList.do" style="color:black;">커뮤니티</a></h2>
			<p>자이언츠의 커뮤니티 공간입니다.</p>
		</div>
	</div>
	<hr size="0.05" width="100%" noshade style="margin-bottom:3%">
	<form action="commuList.do" id="search_form" method="get"  style="padding-bottom: 24px;">
		<ul class="search align-center">
			<li style="margin: 0px 11px 10px 0;">
				<select name="keyfield" id="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">SELECTED</c:if>>제목</option>
					<option value="2" <c:if test="${param.keyfield == 2}">SELECTED</c:if>>작성자</option>
					<option value="3" <c:if test="${param.keyfield == 3}">SELECTED</c:if>>내용</option>
				</select>
			</li>
			<li style="margin: 0px 11px 10px 0;">
				<input type="search" name="keyword" id="keyword" value="${param.keyword}" style="height:30px;">
			</li>
			<li>
				<input type="submit" value="검색" style="height:30px;"  class="accept-btn">
			</li>
		</ul>
	
	
		<!-- 정렬 -->
		<div class="align-right" >
			<select id="order" name="order" style="height:30px;">
				<option value="1" 
				  <c:if test="${param.order == 1}">selected</c:if>>최신글</option>
				<option value="2" 
				  <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				<option value="3" 
				  <c:if test="${param.order == 3}">selected</c:if>>추천수</option>
				<option value="4" 
				  <c:if test="${param.order == 4}">selected</c:if>>댓글수</option>
			</select>
			<script type="text/javascript">
				$(function(){
					$('#order').change(function(){
						location.href='commuList.do?keyfield='+$('#keyfield').val() 
											+ '&keyword='+$('#keyword').val() 
											+ '&order='+$('#order').val();
					});
				});
			</script>
			
			<c:if test="${!empty user}">
			<input type="button" value="글쓰기" onclick="location.href='write.do'" class="accept-btn">
			</c:if>
			<c:if test="${!empty user && user.mem_auth == 9}">
			<input type="button" value="신고목록" onclick="location.href='commuRepoList.do'" class="accept-btn">
			</c:if>
			
		</div>
	</form>
	
	<!-- 목록 -->
	<c:if test="${count == 0}">
		<div class="result-display">표시할 게시물이 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<table class="striped-table">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>추천수</th>
			</tr> 
			<c:forEach var="commu" items="${list}">
				<tr>
					<td class="align-center">${commu.commu_num}</td>
					<td class="align-center commu_title" width="500">
						<a href="detail.do?commu_num=${commu.commu_num}">${commu.commu_title} (${commu.re_cnt})</a>
					</td>
					<td class="align-center">
						<c:if test="${empty commu.mem_nickname}">${commu.mem_id}</c:if>
						<c:if test="${!empty commu.mem_nickname}">${commu.mem_nickname}</c:if>
					</td>
					<td class="align-center">${commu.commu_date}</td>
					<td class="align-center">${commu.commu_hit}</td>
					<td class="align-center">${commu.fav_cnt}</td>
				</tr>
			</c:forEach>
		</table>
		<!-- 페이지 -->
		<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 커뮤니티 목록 끝 -->