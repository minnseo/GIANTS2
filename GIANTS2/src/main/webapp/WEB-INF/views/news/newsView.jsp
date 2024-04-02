<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 뉴스 상세 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/news.css">
<div class="page-main">
	<div class="news-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>자이언츠 뉴스</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<div class="align-right news-btn">
		<c:if test="${!empty user && user.mem_auth == 9}">
		<input type="button" value="수정" onclick="location.href='newsUpdate.do?news_num=${news.news_num}'">
		<input type="button" value="삭제" id="delete_btn">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			
			delete_btn.onclick = function(){
				let choice = confirm('삭제하시겠습니까?');
				
				if(choice){
					location.replace('newsDelete.do?news_num=${news.news_num}')
				}
			}; 
		</script>
		</c:if>
	</div>
	<div class="news-table">
		<table id="detail_tb">
			<tr>
				<th style="border-top-color:#dd032f;">제목</th>
				<td colspan="5" style="border-top-color:#dd032f;">${news.news_title}</td>
			</tr>
			<tr> 
				<th>작성자</th>
				<td>
					<c:if test="${empty news.mem_nickname}">${news.mem_id}</c:if>
					<c:if test="${!empty news.mem_nickname}">${news.mem_nickname}</c:if>
				</td>
				<th>작성일자</th>
				<td>${news.news_regdate}</td>
				<th>조회수</th>
				<td width="79">${news.news_hit}</td>
			</tr>
		</table> 
	</div>
	<hr size="1" width="100%">
	<div class="news-content">
		${news.news_content}
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
		<input type="button" value="목록" onclick="location.href='newsList.do'">
	</div>
	
</div>
<!-- 뉴스 상세 끝 -->