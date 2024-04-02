<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- MyPage menu S -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/profile.js"></script>
<div class="side-bar">
	<ul>
		<li>
			<img src="${pageContext.request.contextPath}/member/photoView.do" width="200" height="200" class="my-photo">
			<div class="camera" id="photo_btn">
				<img src="${pageContext.request.contextPath}/images/camera.png" width="35">
			</div>
		</li>
		<li>
			<div id="photo_choice" style="display:none;" class="align-center">
				<input type="file" id="upload" accept="image/gif,image/png,image/jpeg"><br>
				<input type="button" value="전송" id="photo_submit" class="default-btn">
				<input type="button" value="취소" id="photo_reset" class="delete-btn">
			</div>
		</li>
	</ul>
	<ul>
		<li>
			<input type="button" value="비밀번호변경" onclick="location.href='${pageContext.request.contextPath}/member/changePassword.do'" class="menu-btn">
		</li>
		<li>
			<input type="button" value="채팅" onclick="location.href='${pageContext.request.contextPath}/talk/talkList.do'" class="menu-btn">
		</li>
		<li>
			<input type="button" value="회원탈퇴" onclick="location.href='${pageContext.request.contextPath}/member/delete.do'" class="menu-btn">
		</li>
	</ul>
</div>
<!-- MyPage menu E -->
