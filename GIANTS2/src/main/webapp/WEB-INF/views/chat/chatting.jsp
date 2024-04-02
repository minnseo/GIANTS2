<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KMS/chat.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/chatting.js"></script>
</head>
<body>
<div id="chatting" class="page-main">  
	<div class="align-center">
		<h2>채팅방</h2>
	</div>
	
	<div id="chatting_message"></div>
	
	<form id="detail_form">
		<input type="hidden" name="chatroom_num" value="${param.chatroom_num}" id="chatroom_num">
		<div class="float-left">
			<textarea rows="5" cols="100" name="message" id="message" placeholder="메시지를 입력하세요."></textarea>
		</div>
		<div class="float-left">
			<input class="classic-btn" type="submit" value="전송하기" id="msg_btn">
		</div>
	</form>	
</div>
</body>
</html>