<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/YHJ/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/profile.js"></script>
<div>
	<!-- 일반회원 마이페이지 -->
	<c:if test="${!empty user && user.mem_auth == 2}">
		<div class="mypage-top2">
			<div class="mypage-top-title">
				<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
				<h2>마이페이지</h2>
				<p>자이언츠 마이페이지 입니다.</p>
			</div>
		</div>
		<div class="member-mypage">
			<table class="mem-table">
			<tr>
				<td>아이디</td><td>${member.mem_id}</td>
			</tr>
			<tr>
				<td>이름</td><td>${member.memberDetailVO.mem_name}</td>
			</tr>
			<tr>
				<td>회원분류</td><td>일반회원</td>
			</tr>
			<tr>
				<td>회원가입일</td><td>${member.memberDetailVO.mem_regdate}</td>
			</tr>
			<tr>
				<td>닉네임</td><td>${member.mem_nickname}</td>
			</tr>
			<tr> 
				<td>프로필사진</td>
			</tr>
			<tr>
				<td>
					<img src="${pageContext.request.contextPath}/member/photoView.do" width="100" height="100" class="my-photo">
				</td>
				<td>
					<div class="camera" id="photo_btn">
						<input type="button" value="프로필수정">
					</div>
					<div id="photo_choice" style="display:none;">
						<input type="file" id="upload" accept="image/gif,image/png,image/jpg">
						<input type="button" value="수정" id="photo_submit">	
					    <input type="button" value="취소" id="photo_reset">   
					</div>
				</td>
			</tr>
			</table>
		</div>
	</c:if>
	<!-- 기업회원 마이페이지 -->	
	<c:if test="${!empty user && user.mem_auth == 3}">
		<div class="mypage-top2">
			<div class="mypage-top-title">
				<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
				<h2>기업페이지</h2>
				<p>자이언츠 기업페이지 입니다.</p>
			</div>
		</div>		
		<div class="member-mypage">
			<table class="mem-table">
			<tr>
				<td>아이디</td><td>${company.mem_id}</td>
			</tr>
			<tr>
				<td>사업자명</td><td>${company.companyDetailVO.comp_owner}</td>
			</tr>
			<tr>
				<td>기업명</td><td>${company.companyDetailVO.comp_name}</td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td>
					<c:if test="${company.companyDetailVO.comp_cate == 1}">치킨</c:if>
					<c:if test="${company.companyDetailVO.comp_cate == 2}">술/안주</c:if>
					<c:if test="${company.companyDetailVO.comp_cate == 3}">분식</c:if>
					<c:if test="${company.companyDetailVO.comp_cate == 4}">간식</c:if>
					<c:if test="${company.companyDetailVO.comp_cate == 5}">패스트푸드</c:if>
				</td>
			</tr>
			<tr>
				<td>회원분류</td><td>기업회원</td>
			</tr>
			<tr>
				<td>회원가입일</td><td>${company.companyDetailVO.comp_regdate}</td>
			</tr>
			<tr> 
				<td>프로필사진</td>
			</tr>
			<tr>
				<td>
					<img src="${pageContext.request.contextPath}/member/photoView.do" 
					     width="100" height="100" class="my-photo">
				</td>
				<td>
					<div class="camera" id="photo_btn">
						<input type="button" value="프로필수정">
					</div>
					<div id="photo_choice" style="display:none;">
						<input type="file" id="upload" accept="image/gif,image/png,image/jpg">
						<input type="button" value="수정" id="photo_submit">	
					    <input type="button" value="취소" id="photo_reset">   
					</div>
				</td>
			</tr>
			</table>
		</div>
	</c:if>
	<c:if test="${!empty user && user.mem_auth == 9}">
		<div class="mypage-top2">
			<div class="mypage-top-title">
				<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
				<h2>관리자페이지</h2>
				<p>자이언츠 관리자페이지 입니다.</p>
			</div>
		</div>	
		<div class="member-mypage"> 
			<table class="mem-table">
			<tr>
				<td>아이디</td><td>${member.mem_id}</td>
			</tr>
			<tr>
				<td>이름</td><td>${member.memberDetailVO.mem_name}</td>
			</tr>
			<tr>
				<td>회원분류</td><td>관리자</td>
			</tr>
			<tr>
				<td>회원가입일</td><td>${member.memberDetailVO.mem_regdate}</td>
			</tr>
			</table>
		</div>
	</c:if>
</div>
