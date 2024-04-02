<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
table {
    width: 100%;
    border: 1px solid #444444;
    border-collapse: collapse;
}
 th, td {
    border: 1px solid #444444;
  }
  
#output_fav, .output_rfav {
    cursor: pointer;
    width: 6%;
    margin-bottom: 2%;
}  margin: 10px 10px;
}
</style>
<!-- 게시글 상세 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LHJ/commu.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/commu.reply.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/commu.fav.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<div class="page-main">
	<div class="main-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>자이언츠 커뮤니티</h2>
	</div>
	

	<div class="commu-table">
		<table id="detail_tb">
			<tr>
				<th style="border-top-color:#dd032f;">제목</th>
				<td colspan="5" style="border-top-color:#dd032f;">${commu.commu_title}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<c:if test="${!empty commu.mem_nickname}">${commu.mem_nickname}</c:if>
					<c:if test="${empty commu.mem_nickname}">${commu.mem_id}</c:if>
				</td>
				<th>작성일자</th>
				<td>
					<c:if test="${empty commu.commu_modifydate}">${commu.commu_date}</c:if>
					<c:if test="${!empty commu.commu_modifydate}">(수정일) ${commu.commu_modifydate}</c:if>
				</td>
				<th>조회수</th>
				<td headers="hit">${commu.commu_hit}</td>
			</tr>
		</table>
	</div>
	<div class="commu-content">
		${commu.commu_content}
	</div>
	
	
	
	
	
	
	<div class="align-center">
		<%-- 좋아요 버튼 및 개수 --%>
		<img id="output_fav" data-num="${commu.commu_num}" 
			 src="${pageContext.request.contextPath}/images/fav01.png" width="40">
		<span id="output_fcount" style="margin-left: -5%;"></span>
		
	</div>
	
	
	<div class="align-right">
		<c:if test="${!empty user}">
		<input type="button" value="신고하기" onclick="location.href='commuRepo.do?commu_num=${commu.commu_num}'" class="accept-btn">
		</c:if>
		<input type="button" value="목록" onclick="location.href='commuList.do'" class="default-btn">
		<c:if test="${!empty user && user.mem_num==commu.mem_num}">
		<input type="button" value="수정" onclick="location.href='update.do?commu_num=${commu.commu_num}'" class="accept-btn">
		</c:if>
		<c:if test="${!empty user && user.mem_num==commu.mem_num || user.mem_auth == 9}">
		<input type="button" value="삭제" id="delete_btn" class="accept-btn">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick=function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					alert('삭제되었습니다!');
					//히스토리를 지우면서 이동
					location.replace('delete.do?commu_num=${commu.commu_num}');
				}
			};
		</script>
		</c:if>
	</div>
	
	


	<!-- 댓글 UI 시작 -->
	<div id="reply_div" style="margin-top:3%;">
		<span class="re-title">커뮤니티 댓글</span>
		<%-- 댓글 수 --%>
		<b><span id="output_rcount" style="margin-left:84%;"></span></b>
		
		
		<form id="re_form">
			<input type="hidden" name="commu_num" value="${commu.commu_num}" id="commu_num">
			<textarea rows="3" cols="50" name="re_content" id="re_content" class="rep-content"
			<c:if test="${empty user}">disabled="disabled"</c:if>
			><c:if test="${empty user}">로그인해야 작성할 수 있습니다.</c:if></textarea>
			
			<c:if test="${!empty user}">
			<div id="re_first">
				<span class="letter-count">300/300</span>
			</div>
			<div id="re_second" class="align-right">
				<input type="submit" value="댓글 등록" class="accept-btn" style="margin-left:64%;">
			</div>
			</c:if>
		</form>
	</div>
	
	
	<!-- 댓글 목록 시작 -->
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="더보기">
		
	</div>
	
	
	<!-- 댓글 목록 끝 -->
	<!-- 댓글 UI 끝 -->
</div>
<!-- 게시글 상세 끝 -->