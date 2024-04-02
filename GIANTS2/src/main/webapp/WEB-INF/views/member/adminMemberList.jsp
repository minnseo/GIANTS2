<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<!-- 관리자 : 회원목록 시작 -->
<script type="text/javascript">
	$(function(){
		//검색 유효성 체크
		$('#search_form').submit(function(){
			if($('#keyword').val().trim())==''){
				alert('검색어를 입력하세요.');
				$('#keyword').val().focus();
				return false;
			}
		});

	})
</script>
<div class="mypage-top2">
	<div class="mypage-top-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>회원목록</h2>
		<p>자이언츠 회원목록 입니다.</p>
	</div>
</div>
<div class="mypage-form">
	<form action="admin_list.do" id="search_form" method="get">
		<ul class="search">
			<li>
				<select name="keyfield">
					<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>ID</option>
					<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>이름</option>
					<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>이메일</option>
					<option value="4" <c:if test="${param.keyfield == 4}">selected</c:if>>전체</option>
				</select>	
			</li>
			<li>
				<input type="search" name="keyword" 
					   id="keyword" value="${param.keyword}">
			</li>
			<li>
				<input type="submit" value="찾기" class="default-btn">
				<input type="button" value="목록" class="default-btn"
					   onclick="location.href='admin_list.do'">
			</li>
		</ul>
	</form>
	<c:if test="${count == 0}">
		<div class="result-display">표시할 회원정보가 없습니다.</div>
	</c:if>
	<c:if test="${count > 0}">
		<table class="striped-table">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>가입일</th>
				<th>회원등급</th>
			</tr> 
			<c:forEach var="member" items="${list}">
				<tr>
					<td>
						<c:if test="${member.mem_auth == 0 || member.mem_auth == 1}">
							${member.mem_id}</c:if>
						<c:if test="${member.mem_auth == 2 || member.mem_auth == 5 || member.mem_auth == 9}">
							${member.mem_id}</c:if>
						<c:if test="${member.mem_auth == 3 || member.mem_auth == 6}">
							${member.mem_id}</c:if>
					</td>
					
					<c:if test="${member.mem_auth == 2}">
						<td class="align-center">${member.mem_name}</td>
						<td class="align-center">${member.mem_phone}</td>
						<td class="align-center">${member.mem_email}</td>
						<td class="align-center">${member.mem_regdate}</td>
					</c:if>
					
					<c:if test="${member.mem_auth == 3}">
						<td class="align-center">${member.comp_owner}</td>
						<td class="align-center">${member.comp_phone}</td>
						<td class="align-center">${member.comp_email}</td>
						<td class="align-center">${member.comp_regdate}</td>
					</c:if>
					
					<c:if test="${member.mem_auth == 0 || member.mem_auth == 1 || member.mem_auth == 5 || member.mem_auth == 6 || member.mem_auth == 9}">
						<td class="align-center">-</td>
						<td class="align-center">-</td>
						<td class="align-center">-</td>
						<td class="align-center">-</td>
					</c:if>
					
					<td class="align-center">
						<c:if test="${member.mem_auth == 0}">탈퇴회원</c:if>
						<c:if test="${member.mem_auth == 1}"><a href="admin_updateComp.do?mem_num=${member.mem_num}">정지회원</a></c:if>
						<c:if test="${member.mem_auth == 2}"><a href="admin_updateMem.do?mem_num=${member.mem_num}">일반회원</a></c:if>
						<c:if test="${member.mem_auth == 3}"><a href="admin_updateComp.do?mem_num=${member.mem_num}">기업회원</a></c:if>
						<c:if test="${member.mem_auth == 5}"><a href="admin_updateMem.do?mem_num=${member.mem_num}">일반정지회원</a></c:if>
						<c:if test="${member.mem_auth == 6}"><a href="admin_updateComp.do?mem_num=${member.mem_num}">기업정지회원</a></c:if>
						<c:if test="${member.mem_auth == 9}">관리자</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
	</c:if>
</div>
<!-- 관리자 : 회원목록 끝 -->