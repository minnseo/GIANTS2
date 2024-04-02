<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KMS/chat.css">
<!-- 채팅방 목록 시작 -->
<script type="text/javascript">
$(function(){
	$('.chatting-link').click(function(event){
		let url = $(this).attr('href');
		open(url,'chat','left=460px,toolbar=no,location=no,status=no,menubar=no,resizable=no,scrollbars=no,width=1000,height=1000');
		event.preventDefault();
	});
});
</script>
<div class="page-main">
	<div class="chatting-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>채팅방 목록</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
		<br><br>
		<c:if test="${count == 0}">
		<div class="result-display">표시할 채팅방이 없습니다.</div>
		</c:if>
		
		<c:if test="${count > 0}">
		<table class="striped-table">
		<c:forEach var="chat" items="${list}">
		<c:choose>
			<c:when test="${chat.chatVO == null}">
			</c:when>
			<c:otherwise>
					<tr>
						<td>
							<img src="${pageContext.request.contextPath}/trading/imageView.do?trade_num=${chat.trade_num}" width="40" height="40">
						</td>
						<td id="chatlist_msg"> 
							<a href="chatting.do?chatroom_num=${chat.chatroom_num}" class="chatting-link">
								<span>${fn:substring(chat.chatVO.message, 0, 45)}</span> <!-- 45자의 메시지가 보여짐-->
							</a>
						</td>
						<td class="room_cnt">
							<c:if test="${chat.room_cnt > 0}">
							<span id="room_cnt"><b>${chat.room_cnt}</b></span> <!-- 읽지 않은 메시지 수 -->
							</c:if>
						</td>
						<td>
							<c:if test="${!empty chat.chatVO.chat_date}">|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${chat.chatVO.chat_date}</c:if>
						</td>
					</tr>
			</c:otherwise>
		</c:choose>
		</c:forEach>
		</table>
		<br><br>
		<div class="align-center">${page}</div>
		</c:if>
</div>
<!-- 채팅방 목록 끝 -->