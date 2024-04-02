<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 게시글 상세 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KMS/trading.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/videoAdapter.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/trading.mark.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/chat.js"></script>
<div class="page-main">
	<div class="trading-title">
		<img src="${pageContext.request.contextPath}/images/title_icon.gif" class="title-img">
		<h2>중고거래</h2>
		<hr size="0.05" width="100%" noshade>
	</div>
	<div class="trading-body">
	<h2 id="trade_title">${trading.trade_title}</h2>
	<div class="align-right">
		<%-- 북마크 --%>
		<img id="output_mark" data-num="${trading.trade_num}" src="${pageContext.request.contextPath}/images/bookmark1.png" width="40">
		<span id="output_markcnt"></span>	
		<%-- 채팅 --%>
		<img id="chat" data-num="${trading.trade_num}" src="${pageContext.request.contextPath}/images/bubble_speech.png" width="40">
	</div>
	<ul class="detail-info">
		<li>
			<img src="${pageContext.request.contextPath}/member/viewProfile.do?mem_num=${trading.mem_num}" width="40" height="40" class="my-photo">
		</li>
		<li>
			<c:if test="${empty trading.mem_nickname}">${trading.mem_id}</c:if>
			<c:if test="${!empty trading.mem_nickname}">${trading.mem_nickname}</c:if>
			<br>
			<c:if test="${!empty trading.trade_modifydate}">
				최근 수정일 : ${trading.trade_modifydate}	
			</c:if>
			<c:if test="${empty trading.trade_modifydate}">
				작성일 : ${trading.trade_date}	
			</c:if>
			조회: ${trading.trade_hit}
		</li>
	</ul>
	<hr size="1" width="100%">
	<div class="detail-content">
		${trading.trade_content}
	</div>
	<hr size="1" width="100%">
	<div class="align-right">
		<c:if test="${!empty user && user.mem_num == trading.mem_num}"> <!-- 로그인한 회원번호와 작성자 회원번호가 같을 시 -->
		<input type="button" value="수정" onclick="location.href='tradingUpdate.do?trade_num=${trading.trade_num}'" class="classic-btn small">
		<input type="button" value="삭제" id="delete_btn" class="red-btn small">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick = function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					//히스토리 정보 삭제
					location.replace('tradingDelete.do?trade_num=${trading.trade_num}');
				}
			};
		</script>
		</c:if>
		<c:if test="${!empty user && user.mem_auth == 9}"> <!-- 로그인한 회원번호가 관리자일 시 -->
		<input type="button" value="삭제" id="delete_btn" class="red-btn small">
		<script type="text/javascript">
			let delete_btn = document.getElementById('delete_btn');
			delete_btn.onclick = function(){
				let choice = confirm('삭제하시겠습니까?');
				if(choice){
					//히스토리 정보 삭제
					location.replace('tradingDelete.do?trade_num=${trading.trade_num}');
				}
			};
		</script>
		</c:if>
		<input type="button" value="목록" onclick="location.href='tradingList.do'" class="classic-btn small">
	</div>
	</div>
</div>
<!-- 게시글 상세 끝 --> 