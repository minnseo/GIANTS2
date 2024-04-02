<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 뉴스 목록 시작 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KOY/news.css">
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim() == ''){
				alert('검색어를 입력하세요.');
				$('#keyword').val('').focus();
				return false;
			}
		});
		
		$(document).ready(function() {
		    var tdElement = $(".news-hit-result"); // td 요소 선택
		    
		    // td 요소에서 내용 가져오기
		    var dateTimeString = tdElement.text().trim();
		    
		    // 시분초를 제외하고 날짜 정보만 출력
		    var datePart = dateTimeString.split(" ")[0];
		    
		    // 결과를 화면에 출력
		    $(".news-hit-result").text(datePart);
		});
		
	});
</script>
<div class="page-main">
	<div class="news-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>자이언츠 뉴스</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<form action="newsList.do" id="search_form" method="get">
			<ul class="search">
				<li>
					<select name="keyfield" id="keyfield">
						<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>제목+내용</option>
						<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
						<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
						
					</select>
				</li>
				<li>
					<input type="search" name="keyword" id="keyword" value="${param.keyword}">
				</li>
				<li>
					<input type="submit" value="찾기">
				</li>
			</ul>
			<div class="align-left">
				<select id="order" name="order">
					<option value="1" <c:if test="${param.order == 1}">selected</c:if>>최신</option>
					<option value="2" <c:if test="${param.order == 2}">selected</c:if>>조회수</option>
				</select>
				<script type="text/javascript">
					$(function(){
						$('#order').change(function(){
							location.href='newsList.do?keyfield=' + $('#keyfield').val() + '&keyword=' + $('#keyword').val() + '&order=' + $('#order').val();
						});
					});
				</script>
			</div>
		</form>
		<c:if test="${count == 0}">
		<div>표시할 뉴스가 없습니다.</div>
		</c:if>
		<c:if test="${count > 0}">
		<div class="news-list">
			<table>
				<tr class="first-tr">
					<th style="width:5%;">번호</th>
					<th>제목</th>
					<th style="width:10%;">작성일</th>
					<th style="width:5%;">조회수</th>
				</tr>
				<c:forEach var="news" items="${list}">
				<tr>
					<td>${news.news_num}</td>
					<td>
						<a href="newsDetail.do?news_num=${news.news_num}">${news.news_title}</a>
					</td>
					<td class="news-hit-result">
						${news.news_regdate}
					</td>
					<td>${news.news_hit}</td>
				</tr>
				</c:forEach>
			</table>
			<div class="align-right">
				<c:if test="${!empty user}">
					<input type="button" value="목록" onclick="location.href='newsList.do'">
					<c:if test="${user.mem_auth == 9}">
					<input type="button" value="뉴스등록" onclick="location.href='newsWrite.do'">
					</c:if>
				</c:if>
			</div>
		</div>
		<div class="align-center">${page}</div>
		</c:if>
</div>
<!-- 뉴스 목록 끝 -->